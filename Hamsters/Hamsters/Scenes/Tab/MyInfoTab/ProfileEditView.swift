//
//  ProfileEditView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/19/23.
//

import SwiftUI

struct ProfileEditView: View {
    @AppStorage(UserDefaultsKey.userName.rawValue) private var storedUserkname: String?
    @AppStorage(UserDefaultsKey.hamsterName.rawValue) private var storedHamsterkname: String?
    @AppStorage(UserDefaultsKey.hamsterImage.rawValue) private var storedHamsterImage: String?

    @State private var userName: String = UserDefaults.standard.string(forKey: UserDefaultsKey.userName.rawValue) ?? ""
    @State private var hamsterName: String = UserDefaults.standard.string(forKey: UserDefaultsKey.hamsterName.rawValue) ?? ""
    @State private var hamsterImage: selectedHam = selectedHam(rawValue: UserDefaults.standard.string(forKey: UserDefaultsKey.hamsterImage.rawValue) ?? "gray") ?? .gray
    
    @State private var hamsterNameLimitWarning = false
    @State private var userNameLimitWarning = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("함께 할 캐릭터를 골라주세요!")
                    .font(.headline)
                    .foregroundStyle(.thoNavy)
                    .padding(.bottom, 16)
                
                HStack(spacing: 20) {
                    ForEach(selectedHam.allCases, id: \.self) { hamster in
                        Button {
                            hamsterImage = hamster
                        } label: {
                            Image(hamsterImage == hamster ? hamster.selectedImageName : hamster.circleIamgeName)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
            
            TextField("", text: $hamsterName)
                .textFieldStyle(CustomTextfieldStyle(warning: $hamsterNameLimitWarning, title: "나의 햄스터 이름"))
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                .onChange(of: hamsterName) { _ in
                    hamsterName = hamsterName.trim()
                    if hamsterName.count > 7 {
                        hamsterNameLimitWarning = true
                        hamsterName = String(hamsterName.prefix(7))
                    } else if hamsterName.count < 7 {
                        hamsterNameLimitWarning = false
                    }
                }
            
            TextField("", text: $userName)
                .textFieldStyle(CustomTextfieldStyle(warning: $userNameLimitWarning, title: "내이름"))
                .padding(.horizontal, 16)
                .onChange(of: userName) { _ in
                    userName = userName.trim()
                    if userName.count > 7 {
                        userNameLimitWarning = true
                        userName = String(userName.prefix(7))
                    } else if userName.count < 7 {
                        userNameLimitWarning = false
                    }
                }
            
            Spacer()
        }
        .padding(.top, 20)
        .navigationTitle("내 정보 변경")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            storedHamsterImage = hamsterImage.rawValue
            
            if userName.count > 0 {
                storedUserkname = userName
            }
            
            if hamsterName.count > 0 {
                storedHamsterkname = hamsterName
            }
        }
    }
}
    
struct CustomTextfieldStyle: TextFieldStyle {
    @Binding var warning: Bool
    
    let title: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.thoNavy)
                .padding(.leading, 8)

            configuration
                .padding(.leading, 8)
                .padding(.vertical, 11)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.thoTextField)
                )
            
            Text("한글, 영문, 특수 문자 사용 최대 7자로 입력해주세요!")
                .font(.footnote)
                .foregroundStyle(warning ? .red : .secondary)
                .padding(.leading, 8)
        }
    }
}

#Preview {
    ProfileEditView()
}
