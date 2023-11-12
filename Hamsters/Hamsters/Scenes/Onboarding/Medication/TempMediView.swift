//
//  TempMediView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/12/23.
//

import SwiftUI

struct TempMediView: View {
    //    @StateObject private var medicineViewModel = MedicineViewModel()
    @EnvironmentObject var medicineViewModel: MedicineViewModel
    @Binding var onboardingPage: Onboarding
//    @Binding var nickname: String
    @State private var isActiveNext = false
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {            
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    // 투여약 추가 로직
                    showingSheet.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("투여약 추가")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.thoNavy)
                    .cornerRadius(15)
                })
                .padding(.bottom, 44)
                .sheet(isPresented: $showingSheet) {
                    AddMedicineView(isActiveNext: $isActiveNext)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, onboardingPage.topPadding)

            VStack {
                VStack (alignment: .leading, spacing: 0){
                    // medicineViewModel에서 medicines 배열을 순회하며 각 Medicine 객체에 대한 행을 생성
                    ForEach(Array(medicineViewModel.medicines.enumerated()), id: \.1.id) { (index, medicine) in
                        
                        // 각각의 Medicine 객체를 사용하여 MedicineRow 뷰를 생성
                        MedicineRow(medicine: medicine)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets()) // 이를 통해 여백이 제거되고 텍스트가 행의 전체 너비를 차지합니다.
            
                        
                        if index < medicineViewModel.medicines.count - 1 {
                            Divider()
                        }
                    }
                }
                
                Spacer()
            }
            .cornerRadius(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 44)
            .padding(.horizontal, 24)
            .scrollContentBackground(.hidden)

            VStack(spacing: 20) {
                Button(action: {
                    onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .smoking
                }, label: {
                    Text("지금은 건너뛰기")
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                })
                .frame(maxWidth: .infinity)
                .disabled(isActiveNext)
                
                OnboardingNextButton(isActive: $isActiveNext, title: onboardingPage.nextButtonTitle) {
                    onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .smoking
                }
            }
        }
        .onAppear {
            if medicineViewModel.medicines.count > 0 {
                isActiveNext = true
            }
        }
    }
}

#Preview {
    TempMediView(onboardingPage: .constant(.medication))
        .environmentObject(MedicineViewModel())
}
