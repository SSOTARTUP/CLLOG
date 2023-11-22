//
//  MyInfoMainView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI

struct MyInfoMainView: View {
    @AppStorage(UserDefaultsKey.userName.rawValue) private var storedUserkname: String?
    @AppStorage(UserDefaultsKey.hamsterImage.rawValue) private var storedHamsterImage: String?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: ProfileEditView().tint(.thoNavy)) {
                        HStack(spacing: 12) {
                            Image(selectedHam(rawValue: storedHamsterImage ?? "gray")!.circleIamgeName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(storedUserkname ?? "이름없음") 님")
                                    .font(.headline)
                                
                                Text("내 이름 및 햄스터 정보 변경")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .listRowBackground(Color.thoTextField)
                
                Section {
                    NavigationLink(destination: QuestionItemEditView()) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundStyle(.thoNavy)
                            
                            Text("질문 항목 편집")
                        }
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image(systemName: "pills.fill")
                                .foregroundStyle(.thoNavy)
                            
                            Text("복용 약물 설정")
                        }
                    }
                    
                    Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/f8a0eee2711e4613a70400bd7ae40132?pvs=4")!) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.thoNavy)
                            
                            Text("개인 정보 처리 방침")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    
                    Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/8dec0150593b404a9071bacbc066c3e0?pvs=4")!) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundStyle(.thoNavy)
                            
                            Text("이용약관")
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .listRowBackground(Color.thoTextField)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .navigationTitle("내 정보")
        }
    }
}

#Preview {
    MyInfoMainView()
}
