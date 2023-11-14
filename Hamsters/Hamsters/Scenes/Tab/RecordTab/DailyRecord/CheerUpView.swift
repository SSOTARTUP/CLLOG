//
//  CheerUpView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/12/23.
//

import SwiftUI

struct CheerUpView: View {
    @Binding var pageNumber: Int
    @Binding var isActiveRecord: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("HamsterV")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 100)
            
            Text("애니메이션 예정")
            
            Spacer()
            
            DailyRecordNextButton(pageNumber: $pageNumber, isActiveRecord: $isActiveRecord, title: "다음")
        }
    }
}

#Preview {
    CheerUpView(pageNumber: .constant(7), isActiveRecord: .constant(true))
}
