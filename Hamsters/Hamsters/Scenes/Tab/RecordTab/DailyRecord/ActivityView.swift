//
//  ActivityView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import SwiftUI

struct ActivityView<T: RecordProtocol>: View {
    
    @State var showingSheet = false
    @State var isActive = true
//    @State var list: Activities = []
    @State var index: Int = -1
    @ObservedObject var viewModel: T

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("운동을 기록해주세요")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                
                Button {
                    index = -1
                    showingSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("운동 추가하기")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.thoNavy)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20 + 16)
                .sheet(isPresented: $showingSheet) {
                    ActivityModalView(list:$viewModel.list,index:index)
                }
            }
            .padding(.bottom, 24)
            
            List {
                Section {
                    ForEach(Array(viewModel.list.filter{ Activity.From(rawValue:$0.from) == .user } .enumerated()),id:\.self.offset) { offset,activity in
                        HStack {
                            Text(activity.name)
                                .font(.body)
                            
                            Spacer()
                            
                            Text(activity.dsc)
                                .font(.body)
                                .foregroundStyle(.thoNavy)
                        }
                        .frame(height:44)
                        .padding(.horizontal,16)
                        .listRowBackground(Color.thoTextField)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                viewModel.list.remove(at: offset)
                            } label: {
                                Label("삭제", systemImage: "trash.fill")
                            }
                            .tint(.red)
                            
                            Button {
                                index = offset
                                showingSheet.toggle()
                            } label: {
                                Label("편집", systemImage: "square.and.pencil")
                            }
                            .tint(.yellow)
                        }
                    }

                } header: {
                    if viewModel.list.filter({ Activity.From(rawValue:$0.from) == .user }).count > 0 {
                        HStack {
                            Text("내가 추가한 운동")
                                .font(.headline)
                                .foregroundStyle(.thoNavy)
                                .bold()
                            
                            Spacer()
                        }
                        .frame(width: screenBounds().width - 48)
                    }
                }
                
                Section {
                    ForEach(viewModel.list.filter{ Activity.From(rawValue:$0.from) == .healthKit }) { activity in
                        HStack {
                            Text(activity.name)
                                .font(.body)
                            
                            Spacer()
                            
                            Text(activity.dsc)
                                .font(.body)
                                .foregroundStyle(.thoNavy)
                        }
                        .frame(height: 44)
                        .padding(.horizontal, 16)
                        .listRowBackground(Color.thoTextField)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                } header: {
                    if viewModel.list.filter({ Activity.From(rawValue:$0.from) == .healthKit }).count > 0 {
                        HStack {
                            Text("연동된 운동 데이터")
                                .font(.headline)
                                .foregroundStyle(.thoNavy)
                                .bold()
                            
                            Spacer()
                        }
                        .frame(width: screenBounds().width - 48)
                    }
                }
            }
            .listRowBackground(Color.blue)
            .background(.white) //추후에 DARK mode 고려.
            .scrollContentBackground(.hidden)
            
            Spacer()
            
            NextButton(title: "다음", isActive: $isActive) {
                viewModel.bottomButtonClicked()
            }
            .padding(.bottom, 40)
        }.onAppear{
            HealthKitManager.shared.fetchWorkouts(.today) { sample, error in
                if error != nil {
                    return
                }
                
                guard let sample = sample else { return }
                
                let healthKitData:Activities = sample
                    .map{Activity(from: .healthKit, name: $0.workoutActivityType.name, time: Int($0.duration) / 60)}
                    .compactMap{ $0 }
                
                DispatchQueue.main.async {
                    viewModel.list.append(contentsOf: healthKitData)
                }
            }
        }
    }
}
typealias Activities = [Activity]

struct Activity: Identifiable, Codable {
    let id = UUID()
    let from: String
    var name: String
    var time: Int
    
    enum From: String {
        case user
        case healthKit
    }
    
    var dsc: String{
        if time % 60 == 0 {
            return "\(self.time/60)시간"
        } else if time < 60 {
            return "\(self.time%60)분"
        } else {
            return "\(self.time/60)시간 \(self.time%60)분"
        }
    }
    
    init?(from: From, name: String, time: Int) {
        guard name.count > 0 && name.count <= 15 else {
            return nil
        }
        
        guard time > 0 else {
            return nil
        }
        
        self.from = from.rawValue
        self.name = name
        self.time = time
    }
}



#Preview {
    ActivityView(viewModel: DailyRecordViewModel())
}
