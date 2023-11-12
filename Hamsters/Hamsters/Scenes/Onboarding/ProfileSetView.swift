//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileSetView: View {
    @AppStorage(UserDefaultsKey.username.rawValue) private var storedUserkname: String = ""
    @AppStorage(UserDefaultsKey.hamstername.rawValue) private var storedHamsterkname: String = ""
    
    @Binding var onboardingPage: Onboarding
    
    @State private var hamName: String = ""
    @State private var name: String = ""
    
    @State private var isActive = false
    @State private var isSelected:selectedHam?
    
    @State var scroll:ScrollViewProxy?
    
    @FocusState private var focusField:ProfileSetView.Field?
    

    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                VStack {
                    HStack {
                        Text("함께 할 캐릭터를 골라주세요!")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.thoNavy)
                        Spacer()
                    }
                    HStack {
                        Button {
                            isSelected = .gray
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(isSelected == .gray ? "GrayCircleHam_s" : "GrayCircleHam")
                        }
                        Spacer()
                        Button {
                            isSelected = .yellow
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(isSelected == .yellow ? "YellowCircleHam_s" : "YellowCircleHam")                        }
                        Spacer()
                        Button {
                            isSelected = .black
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(isSelected == .black ? "BlackCircleHam_s" : "BlackCircleHam")
                        }
                    }
                }
                .padding(EdgeInsets(top: onboardingPage.topPadding, leading: 24, bottom: 20, trailing: 24))
                .id(0)

                VStack(spacing:0) {
                    ProfileInput(input: $hamName,field:.hamName,focusField:focusField)
                        .onSubmit {
                            focusField = .name
                            withAnimation {
                                value.scrollTo(2, anchor: .bottom)
                            }
                        }
                        .focused($focusField,equals: .hamName)
                        .onChange(of: focusField) { isFocused in
                            guard isFocused == .hamName else{
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                                withAnimation {
                                    value.scrollTo(1, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: hamName) { _ in
                            validate()
                        }

                        .padding(.bottom,20)
                        .id(1)
                    ProfileInput(input: $name,field:.name,focusField:focusField)
                        .onSubmit {
                            focusField = nil
                        }
                        .focused($focusField,equals: .name)
                        .onChange(of: focusField) { isFocused in
                            guard isFocused == .name else{
                                return
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                                withAnimation {
                                    value.scrollTo(2, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: name) { _ in
                            validate()
                        }
                        .id(2)
                }
                .padding(.horizontal,16)
            }.onAppear {
                scroll = value
            }
        }
        
        OnboardingNextButton(isActive: $isActive, title: onboardingPage.nextButtonTitle) {
            switch validation{
            case .complete:
                storedUserkname = name
                storedHamsterkname = hamName
                onboardingPage = Onboarding(rawValue: onboardingPage.rawValue + 1) ?? .sex
            case .error(let e):
                if e == "character"{
                    withAnimation {
                        scroll?.scrollTo(0, anchor: .top)
                    }
                }else if e == "hamName"{
                    withAnimation {
                        scroll?.scrollTo(1, anchor: .bottom)
                    }
                }else{
                    withAnimation {
                        scroll?.scrollTo(2, anchor: .bottom)
                    }
                }
            }
        }
        .padding(.top, 10)
    }
}

extension ProfileSetView{
    enum Status{
        case complete
        case error(String)
    }
    
    func validate(){
        switch self.validation{
        case .complete:
            isActive = true
        case .error(_):
            isActive = false
        }
    }
    
    var validation:Status{
        if isSelected == nil{
            return .error("character")
        }else if hamName.count == 0 || hamName.count > 7{
            return .error("hamName")
        }else if name.count == 0 || name.count > 7{
            return .error("name")
        }else{
            return .complete
        }
    }
    
    enum Field:String,Hashable{
        case name = "내 이름"
        case hamName = "나의 햄스터 이름"
    }
    
    enum selectedHam{
        case gray
        case yellow
        case black
    }
    
}

#Preview {
    ProfileSetView(onboardingPage: .constant(.profile))
}
