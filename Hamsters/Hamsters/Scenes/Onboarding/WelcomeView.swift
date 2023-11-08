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
                isPresentedBottomSheet.toggle()
            }) {
                NextButton(title: "시작하기")
            }
            .padding(.horizontal,24)
            .padding(.bottom,30)

            
        }
        .popup(isPresented: $isPresentedBottomSheet) {
            TermsView(isPresentedBottomSheet: $isPresentedBottomSheet)
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
    @Binding var isPresentedBottomSheet:Bool
    @Environment(\.safeAreaInsets) private var safeAreaInsets


    var body: some View{
        VStack(alignment:.center,spacing: 0){
            HStack{
                Spacer()
                Button{
                    isPresentedBottomSheet = false
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
                .padding(.trailing,16)
            }.frame(height: 42)
            .padding(.top,14)
            
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
                        .foregroundStyle(.gray)
                        .fixedSize()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondary)
                }
            })
            .padding(.horizontal,24)
            .padding(.top,40)
            
            Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/8dec0150593b404a9071bacbc066c3e0?pvs=4")!, label: {
                HStack{
                    Text("개인 정보 처리 방침(필수)")
                        .font(.body)
                        .foregroundStyle(.gray)
                        .fixedSize()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondary)
                }
            })
            .padding(.horizontal,24)
            .padding(.top,12)
            
            Button{
                
            }label: {
                NextButton(title:"전체 동의 및 다음")
            }
            .padding(EdgeInsets(top: 50, leading: 24, bottom: 30, trailing: 24))
            .padding(safeAreaInsets)
            

        }
        .background(.white)
        .cornerRadius(10)


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
     //   TermsView()
    }

}
