//
//  DiaryExpendedCalendarView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/22/23.
//

import SwiftUI

struct DiaryExpandedCalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: DiaryMainViewModel
    @State private var goToday: Bool = false
    
//    init() {
//        setNavigationBar()
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                headerSection()
                
                DiaryMonthlyCalendar(goToday: $goToday)
                    .padding(.horizontal, 24)

                bottomSection()
            }
            .navigationTitle("날짜 선택")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        goToday = true
                    } label: {
                        Text("오늘")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

extension DiaryExpandedCalendarView {
    private func setNavigationBar(color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
    
    private func headerSection() -> some View {
        HStack {
            Text("월")
            Spacer()
            Text("화")
            Spacer()
            Text("수")
            Spacer()
            Text("목")
            Spacer()
            Text("금")
            Spacer()
            Text("토")
                .foregroundStyle(.blue)
            Spacer()
            Text("일")
                .foregroundStyle(.red)
        }
        .foregroundStyle(.thoNavy)
        .padding(.vertical)
        .padding(.horizontal, 42)
        .background {
            Rectangle()
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
        }
    }
    
    private func bottomSection() -> some View {
        Group {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.thoTextField)
            
            Button {
                viewModel.move()
                dismiss()
            } label: {
                Text("선택한 날짜로 이동")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 48)
                    .padding(.vertical, 15)
                    .background(.thoNavy)
                    .cornerRadius(15)
                    .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    DiaryExpandedCalendarView()
}
