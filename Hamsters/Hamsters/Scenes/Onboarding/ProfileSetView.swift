//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileSetView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    @State private var isActive = false
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
                            viewModel.selectedHamster = .gray
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(viewModel.selectedHamster == .gray ? "GrayCircleHam_s" : "GrayCircleHam")
                        }
                        Spacer()
                        Button {
                            viewModel.selectedHamster = .yellow
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(viewModel.selectedHamster == .yellow ? "YellowCircleHam_s" : "YellowCircleHam")                        }
                        Spacer()
                        Button {
                            viewModel.selectedHamster = .black
                            focusField = .hamName
                            validate()
                        } label: {
                            Image(viewModel.selectedHamster == .black ? "BlackCircleHam_s" : "BlackCircleHam")
                        }
                    }
                }
                .padding(EdgeInsets(top: viewModel.onboardingPage.topPadding, leading: 24, bottom: 20, trailing: 24))
                .id(0)

                VStack(spacing:0) {
                    ProfileInput(input: $viewModel.hamsterName,field:.hamName,focusField:focusField)
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
                        .onChange(of: viewModel.hamsterName) { _ in
                            validate()
                        }

                        .padding(.bottom,20)
                        .id(1)
                    ProfileInput(input: $viewModel.userName,field:.name,focusField:focusField)
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
                        .onChange(of: viewModel.userName) { _ in
                            validate()
                        }
                        .id(2)
                }
                .padding(.horizontal,16)
            }.onAppear {
                scroll = value
            }
        }
        
        OnboardingNextButton(isActive: $isActive, title: viewModel.onboardingPage.nextButtonTitle) {
            switch validation{
            case .complete:
                viewModel.onboardingPage = .sex
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
        if viewModel.selectedHamster == nil{
            return .error("character")
        }else if viewModel.hamsterName.count == 0 || viewModel.hamsterName.count > 7{
            return .error("hamName")
        }else if viewModel.userName.count == 0 || viewModel.userName.count > 7{
            return .error("name")
        }else{
            return .complete
        }
    }
    
    enum Field:String,Hashable{
        case name = "내 이름"
        case hamName = "나의 햄스터 이름"
    }
}

#Preview {
    ProfileSetView()
}
