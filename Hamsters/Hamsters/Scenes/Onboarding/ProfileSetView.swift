//
//  ProfileSetView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/9/23.
//

import SwiftUI

struct ProfileSetView: View {
    @Binding var pageNumber:Int
    
    @Binding var hamName:String
    @Binding var name:String
    
    @State private var isActive = false
    @State private var isSelected:selectedHam?
    
    @State var scroll:ScrollViewProxy?
    
    @FocusState private var focusField:ProfileSetView.Field?
    

    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                OnboardingProgressBar(pageNumber: $pageNumber)
                Text("안녕하세요! 반가워요:)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    OnboardingBackButton(pageNumber: $pageNumber)
                }
            }
            ScrollViewReader{ value in
                ScrollView{
                    VStack{
                        HStack{
                            Text("함께 할 캐릭터를 골라주세요!")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.thoNavy)
                            Spacer()
                        }
                        HStack{
                            Button{
                                isSelected = .gray
                                focusField = .hamName
                                validate()
                            }label: {
                                Image(isSelected == .gray ? "GrayCircleHam_s" : "GrayCircleHam")
                            }
                            Spacer()
                            Button{
                                isSelected = .yellow
                                focusField = .hamName
                                validate()
                            }label: {
                                Image(isSelected == .yellow ? "YellowCircleHam_s" : "YellowCircleHam")                        }
                            Spacer()
                            Button{
                                isSelected = .black
                                focusField = .hamName
                                validate()
                            }label: {
                                Image(isSelected == .black ? "BlackCircleHam_s" : "BlackCircleHam")
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                    .id(0)

                    Group{
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

                            .padding(.bottom,30)
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
                        .padding(.bottom,10)
                }.onAppear{
                    scroll = value
                }
            }
            
            NextButton(title: "다음", isActive: $isActive) {
                switch validation{
                case .complete:
                    pageNumber += 1
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
            .padding(EdgeInsets(top: 10, leading: 24, bottom: 24, trailing: 20))
        }
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
    ProfileSetView(pageNumber:.constant(1),hamName: .constant(""),name: .constant(""))
}
