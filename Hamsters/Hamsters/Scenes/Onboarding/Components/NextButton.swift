//
//  NextButton.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import SwiftUI

struct NextButton: View {
    var title:String
    var closure:()->Void

    var body: some View {
        Button {
            closure()
        } label: {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(.thoNavy)
                .cornerRadius(15)
        }
    }
}

