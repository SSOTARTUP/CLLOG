//
//  MedicationView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/16/23.
//

import SwiftUI

struct MedicationView: View {
    @StateObject private var medicineViewModel = MedicineViewModel()

    @State var isactive = false
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("투여하시는 약물이\n있나요?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 14)
            
            Text("[앱이름]을 조금 더 Username에게 딱 맞게\n관리할 수 있어요!")
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
                AddMedicineView()
            }
            
            List {
                Text("1")
            }
//            .scrollContentBackground(.hidden)
            .cornerRadius(15)
            .padding(.bottom, 44)
            
            Button(action: {
                // 투여약 추가 로직
            }, label: {
                HStack {
                    Text("다음")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(isactive ? .white : .thoNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(isactive ? .thoNavy : .thoDisabled)
                .cornerRadius(15)
            })
            .padding(.bottom, 6)
            
            Button(action: {
                
            }, label: {
                Text("지금은 건너뛰기")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            })
            .frame(maxWidth: .infinity)
            
            
        }
        .padding(.leading, 24)
        .padding(.trailing, 24)
        
    }
}

#Preview {
    MedicationView()
}
