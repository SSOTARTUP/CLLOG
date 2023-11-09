//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileSetView: View {
    @State var pageNumber:Int = 0

    @State var hamName:String = ""
    @State var name:String = "" //Binding으로 변경
    
    @State private var isActiveNext = false
    @State private var characterLimitWarning = false

    @FocusState private var focusField:ProfileSetView.Field?

    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                OnboardingProgressBar(pageNumber: $pageNumber)
                Text("안녕하세요! 반가워요:)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal,24)
                    .background(.blue)
            }
            .padding(.bottom,16)
            .background(.yellow)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    OnboardingBackButton(pageNumber: $pageNumber)
                }
            }
            ScrollView{
                VStack(alignment:.leading){
                    Text("닉네임 입력")
                        .font(.subheadline)
                        .foregroundStyle(.thoNavy)
                        .opacity(true ? 1 : 1)
                        .padding(.leading, 8)
                    
                    TextField("닉네임 입력", text: $name)
                        .frame(height:44)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.leading, 8)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                        .onTapGesture {
                           // focusField = true
                        }

                        .onSubmit {
                            focusField = .hamName
                        }
                    
                    Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                        .font(.footnote)
                        .foregroundStyle(characterLimitWarning ? .red : .secondary)
                        .padding(.leading, 8)
                        .padding(.top, 6)
                }
                VStack(alignment:.leading){
                    Text("닉네임 입력")
                        .font(.subheadline)
                        .foregroundStyle(.thoNavy)
                        .opacity(true ? 1 : 1)
                        .padding(.leading, 8)
                    
                    TextField("닉네임 입력", text: $hamName)
                        .frame(height:44)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.leading, 8)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                        .onTapGesture {
                           // focusField = true
                        }

                        .onSubmit {
                            focusField = .name
                      //      focused = false
                        }
                        .focused($focusField,equals:.hamName)
                    
                    Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                        .font(.footnote)
                        .foregroundStyle(characterLimitWarning ? .red : .secondary)
                        .padding(.leading, 8)
                        .padding(.top, 6)
                }

            }
            Button{
                print(focusField)
            }label: {
                Text("@@@@")
            }                        .focused($focusField,equals:.name)

        }
    }
}

extension ProfileSetView{
    enum Field:Int,Hashable,CaseIterable{
        case name
        case hamName
    }
}

#Preview {
    ProfileSetView(pageNumber:.constant(1))
}
