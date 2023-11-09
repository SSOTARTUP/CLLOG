//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileInput:View{
    

    @Binding var input:String
    @FocusState var focusField:ProfileSetView.Field?
    
    var fieldId:ProfileSetView.Field

    @State private var characterLimitWarning = false
    
//    init(input: String, focusField: ProfileSetView.Field? = nil, fieldId: ProfileSetView.Field, characterLimitWarning: Bool = false) {
//        self.fieldId = fieldId
//
//      //  self.input = input
//       // self.focusField = focusField
//       // self.characterLimitWarning = characterLimitWarning
//    }
    var body: some View{
        VStack(alignment:.leading){
            Text("닉네임 입력")
                .font(.subheadline)
                .foregroundStyle(.thoNavy)
                .opacity(focusField == fieldId ? 1 : 1)
                .padding(.leading, 8)
            
            TextField("닉네임 입력", text: $input)
                .frame(height:44)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.leading, 8)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .onTapGesture {
                   // focusField = true
                }
                .onChange(of: input) { _ in
                    // 공백 제거
                    input = input.trim()
//                    if input.count == 0 {
//                        isActiveNext = false
//                    } else {
//                        isActiveNext = true
//                    }

                    if input.count > 7 {
                        characterLimitWarning = true
                        input = String(input.prefix(7))
                    } else if input.count < 7 {
                        characterLimitWarning = false
                    }
                }
                .onSubmit {
              //      focused = false
                }
               // .focused($focusField,equals: fieldId)
            
            Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                .font(.footnote)
                .foregroundStyle(characterLimitWarning ? .red : .secondary)
                .padding(.leading, 8)
                .padding(.top, 6)
        }

    }
}
