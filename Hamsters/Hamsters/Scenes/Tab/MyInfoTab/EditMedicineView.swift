//
//  EditMedicineView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/29/23.
//

import SwiftUI

struct EditMedicineView: View {
    @State private var isActiveNext = false
    @State private var showingSheet = false
    @State private var showingAlert = false
    @State private var indexSetToDelete: IndexSet?
    @State private var editingMedicine: Medicine?
    @State private var showingEditSheet = false
    @State private var medicines: [Medicine] = []
    
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
                .padding(.top, 20)
                .padding(.bottom, 44)
                .sheet(isPresented: $showingSheet, onDismiss: loadMedicines) {
                    AddMedicineView(isActiveNext: $isActiveNext)
                }
                .padding(.horizontal, 24)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("현재 복용 중인 약물")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.thoNavy)
                    Text("복용 시간 변경만 가능합니다.\n약물 수정이 필요할 시 삭제 후 다시 설정해주세요.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 5)
                
                VStack (alignment: .leading, spacing: 0) {
                    // medicineViewModel에서 medicines 배열을 순회하며 각 Medicine 객체에 대한 행을 생성
                    List {
                        Section(header: Spacer(minLength: 0)){
                            ForEach(medicines.indices, id: \.self) { index in
                                let medicine = medicines[index]
                                
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
                        .listRowInsets(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                    }
                    .scrollContentBackground(.hidden)
                    .environment(\.defaultMinListHeaderHeight, 1)
                    .sheet(isPresented: $showingEditSheet, onDismiss: { loadMedicines() }) {
                        if let editingMedicine = editingMedicine {
                            AddMedicineView(isActiveNext: $isActiveNext, editingMedicine: editingMedicine)
                        }
                    }
                    .confirmationDialog("이 투여약이 삭제됩니다.", isPresented: $showingAlert, titleVisibility: .visible) {
                        Button("삭제", role: .destructive) {
                            if let indexSet = indexSetToDelete {
                                withAnimation {
                                    indexSet.forEach { index in
                                        let medicineToDelete = medicines[index]
                                        MedicinesManager.shared.deleteMedicine(medicineToDelete) {
                                            loadMedicines()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 28)
            }
            .onAppear(perform: loadMedicines)
        }
        .navigationTitle("복용 약물 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadMedicines() {
        medicines = MedicinesManager.shared.fetchAllMedicines() ?? []
    }
}

#Preview {
    EditMedicineView()
}
