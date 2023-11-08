//
//  WelcomeView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import Foundation
import SwiftUI
import PopupView

struct Info:Identifiable{
    let id = UUID()
    let title:String
    let sub:String
}

struct WelcomeView:View{
    @State private var selectedIndex = 0
    @State var isPresentedBottomSheet: Bool = false

    let infos = [
        Info(title: "새로운 시작을 위한\n첫 걸음", sub: "Clue와 함께 쉽고 간편하게\n나의 증상을 기록하고 관리해요!"),
        Info(title: "나의 증상을\n한눈에 알기 쉽게", sub: "내가 기록한 매일의 기록을\n한 눈에 보기 편하게 알려줘요!"),
        Info(title: "일상을 변화시킬\n나만의 단서", sub: "내가 기록한 매일의 기록이 쌓여\n나의 변화를 보기 쉽게 통계로 보여줘요")
    ]
 
    var body: some View {
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
                isPresentedBottomSheet.toggle()
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
        .popup(isPresented: $isPresentedBottomSheet) {
          VStack {
            HStack {
              Spacer()
              Text("This is Bottom Sheet")
                .padding(.top, 10)
              Spacer()
            }
            Spacer()
          }
          .background(Color.white)
          .frame(height: 150)
          .cornerRadius(10)
        } customize: {
          $0
            .type(.toast)
            .position(.bottom)
            .dragToDismiss(true)
            .closeOnTapOutside(true)
            .backgroundColor(.black.opacity(0.2))
        }
    }
}
struct TermsView:View{
    var body: some View{
        VStack(alignment:.center,spacing: 0){
            Image("HamLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height:100)
            Text("원활한 서비스 이용을 위해\n먼저 이용약관 제공에 동의해 주세요.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .bold()
                .padding(.top,16)
            Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/f8a0eee2711e4613a70400bd7ae40132?pvs=4")!, label: {
                HStack{
                    Text("개인 정보 처리 방침(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondary)
                }
            }).padding(.horizontal,16)
                .padding(.top,40)
            
            Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/8dec0150593b404a9071bacbc066c3e0?pvs=4")!, label: {
                HStack{
                    Text("개인 정보 처리 방침(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondary)
                }
            })
            .padding(.horizontal,16)
            .padding(.top,12)
        }.frame(width:380)
            .background(.red)
    }
}
extension WelcomeView{
    func setUpDot(){
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
    }
}
#Preview{
    ZStack{
        WelcomeView()
        TermsView()
    }

}
