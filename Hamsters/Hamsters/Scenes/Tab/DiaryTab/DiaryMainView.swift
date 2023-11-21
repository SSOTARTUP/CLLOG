//
//  DiaryMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DiaryMainView: View {
    
    @StateObject var viewModel = DiaryMainViewModel()
    @State var isPresentedBottomSheet: Bool = false
    
    var body: some View {
        ScrollView {
            Button {
//                //viewModel.initialize(date: Date())
//                viewModel.selectedDate = Date()
                
            } label: {
                Text("CLICK ME")
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isPresentedBottomSheet) {
            DiaryUpdateView(viewModel: viewModel)
        }
    }
}

extension DiaryMainView {
    func showModal(_ currentPage: DailyRecordPage) {
        isPresentedBottomSheet.toggle()
        viewModel.currentPage = currentPage
    }
}

#Preview {
    DiaryMainView()
}
