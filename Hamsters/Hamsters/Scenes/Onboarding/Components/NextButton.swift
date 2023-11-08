//
//  NextButton.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import SwiftUI

struct NextButton: View {
    var title:String
    
    var body: some View {
        Text(title)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height:52)
            .background(.thoNavy)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}

