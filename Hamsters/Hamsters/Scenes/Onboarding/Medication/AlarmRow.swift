//
//  AlarmRow.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

// 각 알람 행을 나타내는 뷰입니다. 여기에는 DatePicker와 삭제 버튼, 그리고 필요에 따라 토글을 포함할 수 있습니다.
struct AlarmRow: View {
    @Binding var alarm: AlarmItem // 단일 알람에 대한 바인딩입니다. 'Alarm'은 당신의 알람 데이터 모델이어야 합니다.
    var removeAction: () -> Void
    
    var body: some View {
        HStack {
            
            // 알람을 삭제하는 버튼입니다.
            //            Button(action: {
            //                // 알람 삭제 처리 로직이 들어갑니다.
            //                // 이 부분은 당신의 알람 데이터 구조와 상호작용하는 방법에 따라 달라집니다.
            //
            //
            //            }) {
            //                Image(systemName: "minus.circle.fill")
            //                    .foregroundColor(.red)
            //            }
            
            Button(action: removeAction, label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            })
            
            DatePicker("", selection: $alarm.date, displayedComponents: .hourAndMinute)
                .labelsHidden() // DatePicker에서 레이블을 숨깁니다.
            
            // 필요에 따라 여기에 토글 버튼을 추가할 수 있습니다.
            // 예: Toggle("Enabled", isOn: $alarm.isEnabled)
            
            Spacer()
            
            Toggle("", isOn: $alarm.isEnabled)
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}


#Preview {
    // 현재 시간으로 초기화된 예시 알람 데이터
    
    AlarmRow(alarm: .constant(AlarmItem(date: Date())), removeAction: {
        print("ss")
    })
}

