//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileInput:View{
    
    @Binding var input:String
    var field:ProfileSetView.Field
    var focusField:ProfileSetView.Field?
    
    
    var body: some View{
        VStack(alignment:.leading){
            Text("\(field.rawValue) 입력")
                .font(.subheadline)
                .foregroundStyle(.thoNavy)
                .opacity(field.rawValue == focusField?.rawValue ? 1 : 0)
                .padding(.leading, 8)
            
            TextField(field.rawValue == focusField?.rawValue ? "" : "\(field.rawValue) 입력", text: $input)
                .frame(height:44)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.leading, 8)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .onChange(of: input) { _ in
                    input = input.trim()
                }
            Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                .font(.footnote)
                .foregroundStyle(input.count > 7 ? .red : .secondary)
                .padding(.leading, 8)
                .padding(.top, 6)
        }

    }
}
