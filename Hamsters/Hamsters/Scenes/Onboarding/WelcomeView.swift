//
//  WelcomeView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import Foundation
import SwiftUI


struct Info:Identifiable{
    let id = UUID()
    let title:String
    let sub:String
}

struct WelcomeView:View{
    @State private var selectedIndex = 0
    
    let infos = [
        Info(title: "새로운 시작을 위한\n첫 걸음", sub: "Clue와 함께 쉽고 간편하게\n나의 증상을 기록하고 관리해요!"),
        Info(title: "나의 증상을\n한눈에 알기 쉽게", sub: "내가 기록한 매일의 기록을\n한 눈에 보기 편하게 알려줘요!"),
        Info(title: "일상을 변화시킬\n나만의 단서", sub: "내가 기록한 매일의 기록이 쌓여\n나의 변화를 보기 쉽게 통계로 보여줘요")
    ]
 
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                TabView(selection: $selectedIndex) {
                    ForEach(infos.indices,id:\.self) { index in
                        VStack(spacing:0) {
                            Image("HamsterV")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                            Text(infos[index].title)
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.vertical,16)
                                
                            Text(infos[index].sub)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear{
                    setUpDot()
                }
                .frame(height:400)

                Spacer()
                Button(action: {
                    print("시작하기 버튼이 눌렸습니다!")
                }) {
                    Text("시작하기")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height:52)
                        .background(.thoNavy)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal,24)
                .padding(.bottom,30)

                
            }
            
        }

        
    }
}

extension WelcomeView{
    func setUpDot(){
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
    }
}
#Preview{
    WelcomeView()
}
