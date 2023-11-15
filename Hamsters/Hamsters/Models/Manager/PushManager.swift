//
//  PushManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/14/23.
//

import Foundation
import UserNotifications

class PushManager {
    static let shared = PushManager()
    let center = UNUserNotificationCenter.current()

    
    func noti(_ push: Push) async -> Status{
        
        guard await requestNotification() == .success else {
            return .authorizedFail
        }
        
        if push.weekDays != nil {
            return await pushSpecificDay(push)
        } else {
            return await pushEveryday(push)
        }

    }
    
}

//MARK: 권한 요청 및 확인
extension PushManager {
    
    func requestNotification() async -> Status {
        var status:Status = .error
        
        await withCheckedContinuation { continuation in
            center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if granted {
                    status = .success
                } else {
                    status = .refused
                }
                continuation.resume()
            }
        }

        return status
    }
    
    func checkNotification(identifier: String) async -> Bool {
        var bool = false
        
        await withCheckedContinuation { continuation in
            center.getPendingNotificationRequests { requests in
                let isRegistered = requests.contains { $0.identifier == identifier }
                
                if isRegistered {
                    bool = true
                } else {
                    bool = false
                }
                continuation.resume()
            }
        }

        return bool
    }
}

//MARK: 푸시 노티
extension PushManager {
    
    private func pushEveryday(_ push: Push) async -> Status {

        // 기존 알림 제거
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["all:\(push.hour):\(push.minute)"])
        
        // 알림 컨텐츠 정의
        let content = UNMutableNotificationContent()
        content.title = "스케줄된 알림"
        content.body = "알림이 설정된 시간에 도착했습니다."

        // 알림 트리거 설정
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        dateComponents.day! += push.pushType.rawValue  // 현재 날짜에 하루 추가
        
        dateComponents.hour = push.hour
        dateComponents.minute = push.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: "all:\(push.hour):\(push.minute)", content: content, trigger: trigger)

        // 알림 스케줄링
        var status:Status = .error
        
        await withCheckedContinuation { continuation in
            center.add(request) { error in
                if let error = error {
                    print("알림 스케줄링 오류: \(error)")
                }
                status = .success
                continuation.resume()
            }
        }
        
        return status
    }
    
    private func pushSpecificDay(_ push: Push) async -> Status {
        
        
        guard let weekDays = push.weekDays else {
            return .error
        }
        
        var status:Status = .success
        
        if await checkNotification(identifier: "all:\(push.hour):\(push.minute)") {
            return .success
        }
        
        for weekDay in weekDays {
            if await checkNotification(identifier: "\(weekDay.rawValue):\(push.hour):\(push.minute)"){
                continue
            }
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(weekDay.rawValue):\(push.hour):\(push.minute)"])
            
            // 알림 컨텐츠 정의
            let content = UNMutableNotificationContent()
            content.title = "스케줄된 알림"
            content.body = "알림이 설정된 시간에 도착했습니다."

            // 알림 트리거 설정
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            dateComponents.day! += push.pushType.rawValue  // 현재 날짜에 하루 추가
            dateComponents.weekday = weekDay.rawValue
            dateComponents.hour = push.hour
            dateComponents.minute = push.minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // 알림 요청 생성
            let request = UNNotificationRequest(identifier: "\(weekDay.rawValue):\(push.hour):\(push.minute)", content: content, trigger: trigger)

            // 알림 스케줄링
            await withCheckedContinuation { continuation in
                center.add(request) { error in
                    if let error = error {
                        print("알림 스케줄링 오류: \(error)")
                        status = .error
                    }
                    continuation.resume()
                }
            }
        }
        
        return status
    }
}

extension PushManager {
    enum PushType: Int {
        case today
        case tommorow
    }
    
    enum Status {
        case success
        case refused
        case authorizedFail
        case error
    }
    
    enum WeekDay: Int {
        case sunday = 1
        case monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    struct Push {
        let pushType: PushType
        let hour: Int
        let minute: Int
        var weekDays: [WeekDay]?
    }
}
