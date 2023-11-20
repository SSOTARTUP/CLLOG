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
    @State var currentPage: DailyRecordPage?
    
    var body: some View {
        ScrollView {
            Button {
                isPresentedBottomSheet.toggle()
            } label: {
                Text("CLICK ME")
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isPresentedBottomSheet) {
            DiaryUpdateView(currentPage: currentPage)
        }
    }
}

struct modalView: View {
    var body: some View {
        GeometryReader { geometry in
            Text("HI")
                .frame(width: 300,height:300)
                .background(.blue)
                .presentationDetents([.height(geometry.size.height)])
               // .frame(height: geometry.size.height)
        }


    }
}
#Preview {
    DiaryMainView()
}
