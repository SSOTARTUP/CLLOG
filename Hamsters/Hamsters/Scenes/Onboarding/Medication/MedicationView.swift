//
//  MedicationView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct MedicationView: View {
    //    @StateObject private var medicineViewModel = MedicineViewModel()
    @EnvironmentObject var medicineViewModel: MedicineViewModel
    @Binding var pageNumber: Int
    @Binding var nickname: String
    @State private var isActiveNext = false
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OnboardingProgressBar(pageNumber: $pageNumber)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("투여하시는 약물이\n있나요?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 14)
                    
                    Text("Clue가 \(nickname)님을 더 잘 케어할 수 있어요!")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 44)
                    
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
                .padding(.leading, 24)
                .padding(.trailing, 24)
                
                
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
                        // 로우 삭제 및 편집 추가 필요
    //                    .onDelete(perform: medicineViewModel.deleteMedicine)
                        
//                        // 예시 로우
//                        MedicineRow(medicine: Medicine(name: "콘서타", capacity: "60", unit: "정", frequency: [.saturday], startTime: Date.now, alarms: [.init(date: Date.now)], sortedDays: "토"))
                    }
                    
                    Spacer()
                }
                .cornerRadius(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 44)
                .padding(.horizontal, 24)
                .scrollContentBackground(.hidden)
                
                
                VStack(spacing: 8) {
                    OnboardingNextButton(isActive: $isActiveNext, pageNumber: $pageNumber)

                    Button(action: {
                        pageNumber += 1
                    }, label: {
                        Text("지금은 건너뛰기")
                            .font(.footnote)
                            .foregroundStyle(Color.secondary)
                    })
                    .frame(maxWidth: .infinity)
                    .disabled(isActiveNext)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 6)
                
            }
            .onAppear {
                if medicineViewModel.medicines.count > 0 {
                    isActiveNext = true
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    OnboardingBackButton(pageNumber: $pageNumber)
                }
            }
        }
    }
}

#Preview {
    MedicationView(pageNumber: .constant(3), nickname: .constant("Hamm"))
        .environmentObject(MedicineViewModel())
}
