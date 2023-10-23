//
//  DiaryMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct DiaryMainView: View {
    var body: some View {
        ScrollView {
            Image("DiaryPrototype")
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DiaryMainView()
}
