//
//  MedicationView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct MedicationView: View {
    @EnvironmentObject var medicineViewModel: MedicineViewModel
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel

    @State private var isActiveNext = false
    @State private var showingSheet = false
    @State private var showingAlert = false
    @State private var indexSetToDelete: IndexSet?
    
    @State private var editingMedicine: Medicine?
    @State private var showingEditSheet = false
    
    var body: some View {
        NavigationStack {
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
                .padding(.bottom, 28)
                .sheet(isPresented: $showingSheet) {
                    AddMedicineView(isActiveNext: $isActiveNext)
                }
                .padding(.leading, 24)
                .padding(.trailing, 24)
                
                VStack (alignment: .leading, spacing: 0){
                    // medicineViewModel에서 medicines 배열을 순회하며 각 Medicine 객체에 대한 행을 생성
                    List {
                        ForEach(Array(medicineViewModel.medicines.enumerated()), id: \.1.id) { (index, medicine) in
                            
                            // 각각의 Medicine 객체를 사용하여 MedicineRow 뷰를 생성
                            MedicineRow(medicine: medicine)
                                .frame(maxWidth: .infinity)
                                .listRowInsets(EdgeInsets()) // 이를 통해 여백이 제거되고 텍스트가 행의 전체 너비를 차지합니다.
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        indexSetToDelete = IndexSet(arrayLiteral: index)
                                        showingAlert = true
                                        
                                    } label: {
                                        Label("삭제", systemImage: "trash.fill")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        editingMedicine = medicine
                                        showingEditSheet.toggle()
                                    } label: {
                                        Label("편집", systemImage: "square.and.pencil")
                                    }
                                    .tint(.yellow)
                                }
                        }
                        .listRowBackground(Color(uiColor: .secondarySystemBackground))
                    }
                    .scrollContentBackground(.hidden)
                    .sheet(isPresented: $showingEditSheet) {
                        if let editingMedicine = editingMedicine {
                            AddMedicineView(isActiveNext: $isActiveNext, editingMedicine: editingMedicine)
                        }
                    }
                    .confirmationDialog("이 투여약이 삭제됩니다.", isPresented: $showingAlert, titleVisibility: .visible) {
                        Button("삭제", role: .destructive) {
                            if let indexSet = indexSetToDelete {
                                withAnimation {
                                    indexSet.map { medicineViewModel.medicines[$0] }.forEach { medicine in
                                        medicineViewModel.deleteMedicine(medicine)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 28)
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                Button(action: {
                    onboardingViewModel.onboardingPage = .smoking
                }, label: {
                    Text("지금은 건너뛰기")
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                })
                .frame(maxWidth: .infinity)
                .disabled(isActiveNext)
                .padding(.bottom, 20)
                
                OnboardingNextButton(isActive: $isActiveNext, title: onboardingViewModel.onboardingPage.nextButtonTitle) {
                    onboardingViewModel.onboardingPage = .smoking
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
    MedicationView()
        .environmentObject(MedicineViewModel())
}
