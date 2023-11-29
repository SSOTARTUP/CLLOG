//
//  RecordMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI
import CoreData

struct RecordMainView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    @StateObject var viewModel = RecordMainViewModel()
    @State private var isActiveSheet = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: 배경
            Color.sky
            
            VStack {
                Image("Cloud")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 24)
                
                Spacer()
                
                Image("Mound")
                    .resizable()
                    .scaledToFit()
                    .offset(y: -200)
            }
            
            // MARK: 헤더
            VStack(spacing: 0) {
                HStack {
                    Text(viewModel.selectedDate.monthAndDay)
                    
                    if viewModel.selectedDate.basic == Date().basic {
                        Text("오늘")
                            .fontWeight(.semibold)
                    }
                }
                .padding()

                RecordWeeklyCalendar()
                    .environmentObject(viewModel)
                    .padding(.top)
                    
                Spacer()
                
                Image("goldenHamster")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 160)
                    .padding(.bottom, 28)
              
                if viewModel.status == .none {
                    RecordButton(status: isToday) {
                        isActiveSheet = true
                    }
                    .padding(.bottom, 28)

                }

                
                DailyMedicationList(viewModel: viewModel)
            }
            .padding(.top, safeAreaInsets.top)
        }
        .ignoresSafeArea(.container, edges: .top)
        .fullScreenCover(isPresented: $isActiveSheet) {
            DailyRecordView(isActiveSheet: $isActiveSheet)
        }
    }
}

extension RecordMainView {
    struct RecordWeeklyCalendar: View {
        @EnvironmentObject var viewModel: RecordMainViewModel
        @State private var weeklyHeight: CGFloat = 220.0
       
        var body: some View {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "월" ? 1 : 0)

                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "화" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "수" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "목" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "금" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "토" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(viewModel.selectedDate.basicWithDay.suffix(1) == "일" ? 1 : 0)
                }
                .padding(.horizontal, 22)
                .frame(height: 80)
                
                WeeklyCalendarView(calendarHeight: $weeklyHeight)
                    .frame(width: screenBounds().width - 38, height: weeklyHeight)
            }
        }
    }
    
    
    
    struct RecordButton: View {
        let status: RecordStatus
        var action: () -> Void
        
        var body: some View {
            Button {
                action()
            } label: {
                Text(status.buttonTitle)
                    .font(.headline)
                    .foregroundStyle(status.buttonTextColor)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(status.buttonBackgroundColor)
                    .cornerRadius(12)
                    .padding(.horizontal, 61)
                    .shadow(color: .black.opacity(status.buttonShadowOpacity), radius: 2, x: 0, y: 4)
            }
            .disabled(status.buttonDisabled)
        }
    }
}


enum RecordStatus {
    case noRecord
    case record
    
    var buttonDisabled: Bool {
        switch self {
        case .noRecord: false
        case .record: true
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noRecord:
            "오늘의 상태 추가하기"
            
        case .record:
            "오늘의 기록 완료!"
        }
    }
        
    var buttonBackgroundColor: Color {
        switch self {
        case .noRecord:
            Color.thoNavy
        case .record:
            Color.thoDisabled
        }
    }
    
    var buttonTextColor: Color {
        switch self {
        case .noRecord:
            Color.white
        case .record:
            Color.thoNavy
        }
    }
    
    var buttonShadowOpacity: Double {
        switch self {
        case .noRecord:
            0.25
        case .record:
            0.0
        }
    }
}

#Preview {
    RecordMainView()
}

