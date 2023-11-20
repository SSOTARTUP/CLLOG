//
//  PushProtocol.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/16/23.
//

import Foundation

protocol PushProtocol:AnyObject {}

extension PushProtocol {
    
    func pushSetting() async -> PushManager.Status {
        
        PushManager.shared.center.removeAllPendingNotificationRequests()
        
        let coreDataManager = CoreDataManager.shared
        let medicines = coreDataManager.fetchAllMedicines()
        var dic:[String:[PushManager.WeekDay]] = [:]
        
        let calendar = Calendar.current
        print(medicines)
        medicines.forEach { medicine in
            for alarm in medicine.alarms {
                if !alarm.isEnabled {
                    continue
                }
                
                let hour = calendar.component(.hour, from: alarm.date)
                let minute = calendar.component(.minute, from: alarm.date)
                
                let weekdays = medicine.frequency.map { $0.weekday }
                
                if dic["\(hour):\(minute)"] == nil {
                    dic["\(hour):\(minute)"] = weekdays
                } else{
                    dic["\(hour):\(minute)"] = Array(Set(dic["\(hour):\(minute)"]! + weekdays))
                }
            }
        }

        for (time, weekdays) in dic {
            let components = time.split(separator: ":").compactMap { Int($0) }
            
            if weekdays.count == 7 {
                let push = PushManager.Push(pushType: .today, hour: components[0], minute: components[1])
                let localStatus = await PushManager.shared.noti(push)
                if localStatus != .success{
                    return localStatus
                }
            }else {
                let push = PushManager.Push(pushType: .today, hour: components[0], minute: components[1], weekDays: weekdays)
                let localStatus = await PushManager.shared.noti(push)
                
                if localStatus != .success{
                    return localStatus
                }
            }
        }
        
        return .success
    }
    

    func pushByCheck(name: String, hour: Int, minute: Int) async -> PushManager.Status {
        
        guard Date.isTimeInPast(hour: hour, minute: minute) else { return .success }
        
        let pushManager = PushManager.shared

        if await pushManager.checkNotification(identifier: "all:\(hour):\(minute)") {
            let push = PushManager.Push(pushType: .tommorow, hour: hour, minute: minute)
            return await pushManager.noti(push)
        }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())

        if await pushManager.checkNotification(identifier: "\(weekday):\(hour):\(minute)") {
            let push = PushManager.Push(pushType: .tommorow, hour: hour, minute: minute, weekDays: [.init(rawValue: weekday)!])
            return await pushManager.noti(push)
        }
        
        return .success
    }
    
    func pushByUnCheck(name: String, hour: Int, minute: Int) async -> PushManager.Status {
                
        let pushManager = PushManager.shared

        if await pushManager.checkNotification(identifier: "all:\(hour):\(minute)") {
            let push = PushManager.Push(pushType: .today, hour: hour, minute: minute)
            return await pushManager.noti(push)
        }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())

        if await pushManager.checkNotification(identifier: "\(weekday):\(hour):\(minute)") {
            let push = PushManager.Push(pushType: .today, hour: hour, minute: minute, weekDays: [.init(rawValue: weekday)!])
            return await pushManager.noti(push)
        }
        
        return .success
    }
}
