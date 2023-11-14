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
    private func cancelNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    func scheduleNotification(hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()

        // 권한 요청
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("허가됨")
            } else {
                print("거부됨")
            }
        }

        // 알림 컨텐츠 정의
        let content = UNMutableNotificationContent()
        content.title = "스케줄된 알림"
        content.body = "알림이 설정된 시간에 도착했습니다."

        // 알림 트리거 설정
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: "push123", content: content, trigger: trigger)

        // 알림 스케줄링
        center.add(request) { error in
            if let error = error {
                print("알림 스케줄링 오류: \(error)")
            }
         //   self.cancelNotification(identifier: "push123")
        }
    }
    func scheduleDailyNoonNotificationStartingTomorrow() {
     //   let center = UNUserNotificationCenter.current()

        // 권한 요청
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            // 권한 처리
        }

        // 알림 컨텐츠 정의
        let content = UNMutableNotificationContent()
        content.title = "매일 정오 알림"
        content.body = "하루 이후에 울리는 알람."

        // 내일 날짜 설정
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        dateComponents.day! += 1  // 현재 날짜에 하루 추가
        dateComponents.hour = 12  // 정오 시간 설정
        dateComponents.minute = 24

        // 알림 트리거 설정 (매일 정오)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // 알림 스케줄링
        center.add(request) { error in
            // 알림 스케줄링 처리
        }
    }
    
    func scheduleNotification() {
        // 권한 요청
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
//            if granted {
//                print("허가됨")
//            } else {
//                print("거부됨")
//            }
//        }

        // 알림 컨텐츠 정의
        let content = UNMutableNotificationContent()
        content.title = "테스트 알림"
        content.body = "이것은 로컬 알림 테스트입니다."

        // 알림 트리거 설정 (5초 후)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // 알림 스케줄링
        center.add(request) { error in
            if let error = error {
                print("알림 스케줄링 오류: \(error)")
            }
        }
    }
}
