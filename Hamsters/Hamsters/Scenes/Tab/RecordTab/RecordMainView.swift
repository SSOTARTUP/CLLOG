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
        
    @State private var selectedDate = Date()
    @State private var isActiveSheet = false
    @State private var dateStatus: DateStatus = .today
    
    @StateObject var viewModel = RecordMainViewModel()
    
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
                    Text(selectedDate.monthAndDay)
                    
                    if selectedDate.basic == Date().basic {
                        Text("오늘")
                            .fontWeight(.semibold)
                    }
                }
                .padding()

                RecordWeeklyCalendar(selectedDate: $selectedDate, dateStatus: $dateStatus)
                    .padding(.top)
                    
                Spacer()
                
                Image("goldenHamster")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 160)
                    .padding(.bottom, 28)
                
                RecordButton(status: dateStatus) {
                    isActiveSheet = true
                }
                .padding(.bottom, 28)
                
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
        @Binding var selectedDate: Date
        @Binding var dateStatus: DateStatus
        @State private var weeklyHeight: CGFloat = 220.0
       
        var body: some View {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "월" ? 1 : 0)

                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "화" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "수" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "목" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "금" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "토" ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.thoNavy)
                        .opacity(selectedDate.basicWithDay.suffix(1) == "일" ? 1 : 0)
                }
                .padding(.horizontal, 22)
                .frame(height: 80)
                
                WeeklyCalendarView(selectedDate: $selectedDate, calendarHeight: $weeklyHeight, existLog: .constant(["2023-11-16", "2023-11-15", "2023-11-13", "2023-11-11", "2023-11-9"]), dateStatus: $dateStatus)
                    .frame(width: screenBounds().width - 38, height: weeklyHeight)
            }
        }
    }
    
    
    
    struct RecordButton: View {
        let status: DateStatus
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
            .disabled(status != .today)
        }
    }
}


enum DateStatus {
    case past
    case today
    case future
        var buttonTitle: String {
            switch self {
            case .past:
                "과거의 기록은 추가할 수 없어요!"
            case .today:
                "오늘의 상태 추가하기"
            case .future:
                "미래의 기록은 추가할 수 없어요!"
            }
        }
        
        var buttonBackgroundColor: Color {
            switch self {
            case .today:
                Color.thoNavy
            default:
                Color.thoDisabled
            }
        }
        
        var buttonTextColor: Color {
            switch self {
            case .today:
                Color.white
            default:
                Color.thoNavy
            }
        }
        
        var buttonShadowOpacity: Double {
            switch self {
            case .today:
                0.25
            default:
                0.0
            }
        }
}

#Preview {
    RecordMainView()
}

