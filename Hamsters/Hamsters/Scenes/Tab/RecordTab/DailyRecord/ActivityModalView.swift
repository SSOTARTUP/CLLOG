//
//  ActivityModalView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import SwiftUI

struct ActivityModalView: View {
    
    @State private var input:String = ""
    @State private var time:Int = 0
    @Binding var list:ActivityView.Activities
    @Environment(\.dismiss) private var dismiss
    
    var index:Int
    
    var body: some View {
        NavigationStack {
            VStack(spacing:0) {
                Text("💪")
                    .font(.largeTitle)
                    .padding(.top,12)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                guard let item = ActivityView.Activity(from: .user, name: input, time: time) else { return }
                                
                                if index != -1 {
                                    list[index] = item
                                } else {
                                    list.append(item)
                                }
                                dismiss()
                            } label: {
                                Text("완료")
                            }
                        }
                    }
                
                Text("운동 추가하기")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top,20)

                VStack(alignment: .leading, spacing:0) {
                    Text("운동 이름")
                        .font(.headline)
                        .foregroundColor(.thoNavy)
                        .bold()
                        .padding(.leading,8)
                        .padding(.bottom,6)

                    TextField("운동 이름" , text: $input)
                        .frame(height:44)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.leading, 8)
                        .background(.thoTextField)
                        .cornerRadius(10)
                        .onChange(of: input) { _ in
                            input = input.trim()
                        }
                    
                    Text("최대 15자까지 입력 가능합니다.")
                        .font(.footnote)
                        .foregroundStyle(input.count > 15 ? .red : .secondary)
                        .padding(.leading, 8)
                        .padding(.top, 6)
                }.padding(.top,48)
                .padding(.horizontal,16)
                
                VStack(alignment:.leading,spacing:0) {
                    Text("운동 시간")
                        .font(.headline)
                        .foregroundColor(.thoNavy)
                        .bold()
                        .padding(.leading,8)
                        .padding(.bottom,6)

                    HStack(spacing:8) {
                        Group {
                            HStack {
                                Button {
                                    timeAdd(.minusHour)
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.body)
                                        .padding(.horizontal,8)
                                        .padding(.vertical,14)
                                        .foregroundStyle(.black)
                                }

                                Spacer()
                                
                                Text("\(time/60) 시간")
                                
                                Spacer()
                                
                                Button {
                                    timeAdd(.plusHour)
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.body)
                                        .padding(8)
                                        .foregroundStyle(.black)
                                }
                            }

                            HStack {
                                Button {
                                    timeAdd(.minusMinute)
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.body)
                                        .padding(.horizontal,8)
                                        .padding(.vertical,14)
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                
                                Text("\(time%60) 분")
                                
                                Spacer()
                                
                                Button {
                                    timeAdd(.plusMinute)
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.body)
                                        .padding(8)
                                        .foregroundStyle(.black)
                                }
                            }

                        }
                        .frame(height:44)
                        .background(.thoTextField)
                        .cornerRadius(10)
                    }
                }
                .padding(.top,28)
                .padding(.horizontal,16)
                
                Image("ActivityModalHam")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250,height:250)
                    .padding(.top,58)
                Spacer()
                    
            }
        }.onAppear {
            if index != -1 {
                input = list[index].name
                time = list[index].time
            }
        }
    }
}

extension ActivityModalView {
    //한 번에 오르고 내리는 '분(minute)' 단위는 60의 약수로 지정해 주세요.
    enum TimeType:Int{
        case plusMinute = 5
        case plusHour = 60
        case minusMinute = -5
        case minusHour = -60
    }
    
    func timeAdd(_ timeType:TimeType){
        switch timeType{
        case .plusHour:
            time += timeType.rawValue
        case .plusMinute:
            if time%60 + timeType.rawValue == 60 {
                time -= (60 - timeType.rawValue)
            } else{
                time += timeType.rawValue
            }
        case .minusMinute:
            if time%60 + timeType.rawValue < 0 {
                time += (60 + timeType.rawValue)
            } else {
                time += (timeType.rawValue)
            }
        case .minusHour:
            if time >= 60 {
                time += timeType.rawValue
            }
        }
    }
}
#Preview {
    ActivityModalView(list:.constant([]),index:-1)
}
