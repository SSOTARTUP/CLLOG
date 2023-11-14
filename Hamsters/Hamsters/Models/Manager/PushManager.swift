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

    func requestNotification() {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("허가됨")
            } else {
                print("거부됨")
            }
        }

    }
    
    func noti(pushType:PushType, hour: Int, minute: Int, completion: @escaping (PushManager.pushStatus) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                self.scheduleNotification(pushType: pushType, hour: hour, minute: minute, completion: completion)
            }else{
                completion(.authorizedFail)

            }
        }
    }
    
    private func scheduleNotification(pushType:PushType, hour: Int, minute: Int, completion: @escaping (PushManager.pushStatus) -> Void) {
        // 기존 알림 제거
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(hour):\(minute)"])
        
        // 알림 컨텐츠 정의
        let content = UNMutableNotificationContent()
        content.title = "스케줄된 알림"
        content.body = "알림이 설정된 시간에 도착했습니다."

        // 알림 트리거 설정
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        dateComponents.day! += pushType.rawValue  // 현재 날짜에 하루 추가
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: "\(hour):\(minute)", content: content, trigger: trigger)

        // 알림 스케줄링
        center.add(request) { error in
            if let error = error {
                print("알림 스케줄링 오류: \(error)")
                completion(.error)
            }
            completion(.success)
        }
    }
    
}


extension PushManager {
    enum PushType: Int {
        case today
        case tommorow
    }
    
    enum pushStatus {
        case success
        case authorizedFail
        case error
    }
}
