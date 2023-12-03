//
//  DiaryContentsView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/22/23.
//

import SwiftUI
import Charts
import WrappingHStack

struct DiaryContentsView: View {
    
    @ObservedObject var viewModel: DiaryMainViewModel
    @State var isPresentedBottomSheet: Bool = false
    @AppStorage(UserDefaultsKey.sex.rawValue) var savedSex: String = "male"
    @AppStorage(UserDefaultsKey.PageControl.period.rawValue) private var isOnPeriod: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.caffeine.rawValue) private var isOnCaffeine: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.smoking.rawValue) private var isOnSmoking: Bool = true
    @AppStorage(UserDefaultsKey.PageControl.drink.rawValue) private var isOnDrink: Bool = true
    let conditionLabels = ["주의력", "과잉행동", "충동성", "조직 및 시간관리"]
    let moodLabels = ["우울함", "고조됨", "화남", "불안함"]
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    var body: some View {
        if viewModel.status == .exist {
            ScrollView {
                VStack(spacing: 16) {
                    // 컨디션 차트
                    VStack(alignment: .leading) {
                        Text("오늘의 컨디션")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 12)
                        Chart {
                            ForEach(Array(zip(conditionLabels, viewModel.userValues)), id: \.0) { label, value in
                                BarMark(
                                    x: .value("Category", label),
                                    y: .value("Value", value),
                                    width: 32
                                )
                                .foregroundStyle(.thoYellow)
                                .cornerRadius(8)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(values: .automatic) { value in
                                AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                                    .foregroundStyle(Color.secondary.opacity(0.6))
                            }
                        }
                        .chartXAxis {
                            AxisMarks(values: conditionLabels) { value in
                                AxisValueLabel() {
                                    if let textValue = value.as(String.self) {
                                        Text("\(textValue)")
                                            .font(.caption2)
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        }
                        .chartYScale(domain: [0, 4])
                        
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .condition
                    }
                    
                    // 기분 프로그래스
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘의 기분")
                            .font(.callout)
                            .fontWeight(.semibold)
                        ForEach(0..<moodLabels.count, id: \.self) { index in
                            if index % 2 == 0 {
                                HStack(spacing: 5) {
                                    ForEach(index..<min(index+2, moodLabels.count), id: \.self) { subIndex in
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(moodLabels[subIndex])
                                                    .font(.footnote)
                                                    .frame(width: 34, alignment: .leading)
                                                
                                                ProgressView(value: viewModel.moodValues[subIndex], total: 4)
                                                    .progressViewStyle(BarProgressStyle(height: 24))
                                                    .frame(height: 24)
                                                    .cornerRadius(8)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding(.top, 16)
                                        }
                                        if subIndex % 2 == 0 { // 첫 번째 항목에만 Spacer 추가
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .mood
                    }
                    
                    // 복용 약물
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘의 복용 약")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 9)
                        if !viewModel.medicines.isEmpty {
                            VStack {
                                ForEach(Array(viewModel.medicines.indices), id: \.self) { index in
                                    let medicine = viewModel.medicines[index]
                                    if index > 0 {
                                        Divider() // 첫 번째 항목을 제외하고 Divider 추가
                                    }
                                    HStack {
                                        Text("\(medicine.name) " + "\(medicine.capacity)\(medicine.unit)")
                                            .font(.body)
                                        Spacer()
                                        Text("\(medicine.times)회")
                                            .font(.body)
                                            .foregroundStyle(.blue)
                                    }
                                    .padding(12)
                                }
                            }
                            .background(.thoTextField)
                            .cornerRadius(10)
                        } else {
                            HStack {
                                Spacer()
                                Text("기록된 약물이 없어요!")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
//                        viewModel.isPresentedBottomSheet = true
//                        viewModel.currentPage = .me
                    }
                    // 오늘의 흔한 부작용
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘의 흔한 부작용")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 9)
                        
                        WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10) {
                            ForEach(viewModel.popularEffect, id: \.self) { effect in
                                Text(effect.rawValue)
                                    .font(.footnote)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule()
                                            .fill(Color.mint)
                                    )
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .sideEffect
                    }
                    
                    // 오늘의 위험 부작용
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘의 위험 부작용")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 9)
                        
                        WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10) {
                            ForEach(viewModel.dangerEffect, id: \.self) { effect in
                                Text(effect.rawValue)
                                    .font(.footnote)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule()
                                            .fill(Color.orange)
                                    )
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .sideEffect
                    }
                    
                    // 수면시간, 체중
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 15) {
                            // 오늘의 수면시간
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 수면시간")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)

                                HStack(alignment: .bottom, spacing: 0) {
                                    Text("\(viewModel.sleepingTime / 60)")
                                        .font(.largeTitle)
                                        .foregroundStyle(.thoNavy)
                                        .bold()
                                    Text("시간")
                                        .font(.body)
                                    
                                    if viewModel.sleepingTime % 60 > 0 {
                                        Text(" \(viewModel.sleepingTime % 60)")
                                            .font(.largeTitle)
                                            .foregroundStyle(.thoNavy)
                                            .bold()
                                        Text("분")
                                            .font(.body)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .sleeping
                            }
                            
                            // 오늘의 체중
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 체중")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                
                                HStack(alignment: .bottom) {
                                    Text(viewModel.weight.description)
                                        .font(.largeTitle)
                                        .foregroundStyle(.green)
                                        .bold()
                                    Text("kg")
                                        .font(.body)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .weightCheck
                            }
                            
                        }
                    }

                    // 운동량
                    VStack(alignment: .leading, spacing: 0) {
                        Text("오늘의 운동량")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 9)
                        
                        if !viewModel.list.isEmpty {
                            VStack(alignment: .leading, spacing: 0) {
                                
                                    Text("내가 추가한 운동")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.thoNavy)
                                        .padding(.bottom, 5)
                                if viewModel.list.contains(where: { Activity.From(rawValue: $0.from) == .user }) {

                                    VStack {
                                        ForEach(Array(viewModel.list.enumerated()), id: \.element.id) { index, activity in
                                            if Activity.From(rawValue: activity.from) == .user {
                                                if index > 0 {
                                                    Divider()
                                                }
                                                HStack {
                                                    Text(activity.name)
                                                        .font(.body)
                                                    Spacer()
                                                    Text(activity.dsc)
                                                        .font(.body)
                                                        .foregroundStyle(.thoNavy)
                                                }
                                                .padding(10)
                                            }
                                        }
                                    }
                                    .background(.thoTextField)
                                    .cornerRadius(10)
                                    .padding(.bottom, 36)
                                } else {
                                    HStack {
                                        Spacer()
                                        Text("추가한 운동이 없어요!")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                }
                                
                                Text("연동된 운동 데이터")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.thoNavy)
                                    .padding(.bottom, 5)
                                
                                if viewModel.list.contains(where: { Activity.From(rawValue: $0.from) == .healthKit }) {
                                    
                                    VStack {
                                        ForEach(Array(viewModel.list.enumerated()), id: \.element.id) { index, activity in
                                            if Activity.From(rawValue: activity.from) == .healthKit {
                                                if index > 0 {
                                                    Divider()
                                                }
                                                HStack {
                                                    Text(activity.name)
                                                        .font(.body)
                                                    Spacer()
                                                    Text(activity.dsc)
                                                        .font(.body)
                                                        .foregroundStyle(.thoNavy)
                                                }
                                                .padding(10)
                                            }
                                        }
                                    }
                                    .background(.thoTextField)
                                    .cornerRadius(10)
                                } else {
                                    HStack {
                                        Spacer()
                                        Text("연동된 데이터가 없어요!")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                }
                            }
                        } else {
                            HStack {
                                Spacer()
                                Text("기록된 항목이 없어요!")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .activity
                    }
                    // 선택 옵션들
                    LazyVGrid(columns: columns, spacing: 15) {
                        // 월경 여부
                        if(isOnPeriod == true && savedSex == "female") {
                            if(viewModel.isPeriod == true) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("월경 여부")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("월경중")
                                        .font(.largeTitle)
                                        .foregroundStyle(.thoNavy)
                                        .bold()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(15)
                                .onTapGesture {
                                    viewModel.isPresentedBottomSheet = true
                                    viewModel.currentPage = .menstruation
                                }
                                
                            } else {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("월경 여부")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 9)
                                    Text("아님")
                                        .font(.largeTitle)
                                        .foregroundStyle(.thoNavy)
                                        .bold()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(15)
                                .onTapGesture {
                                    viewModel.isPresentedBottomSheet = true
                                    viewModel.currentPage = .menstruation
                                }
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("월경 여부")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                Text("-")
                                    .font(.largeTitle)
                                    .foregroundStyle(.thoNavy)
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .menstruation
                            }
                        }
                        
                        // 카페인
                        if(isOnCaffeine == true) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 카페인")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                HStack(alignment: .bottom) {
                                    Text(viewModel.amountOfCaffein.description)
                                        .font(.largeTitle)
                                        .foregroundStyle(.indigo)
                                        .bold()
                                    Text("잔")
                                        .font(.body)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .caffein
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 카페인")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                HStack(alignment: .bottom) {
                                    Text("-")
                                        .font(.largeTitle)
                                        .foregroundStyle(.indigo)
                                        .bold()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .caffein
                            }
                        }
                        
                        // 흡연량
                        if(isOnSmoking == true) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 흡연량")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                
                                let smokingAmount = SmokingAmount.from(value: viewModel.amountOfSmoking)
                                
                                if viewModel.amountOfSmoking > 0 {
                                    HStack(alignment: .bottom, spacing: 5) {
                                        Text(smokingAmount.diaryValue)
                                            .font(.largeTitle)
                                            .foregroundStyle(.pink)
                                            .bold()
                                        
                                        // 흡연량에 따라 추가적인 텍스트 표시
                                        switch smokingAmount {
                                        case .min0:
                                            Text("개피")
                                        case .min1:
                                            Text("개피")
                                        case .min6:
                                            Text("개피")
                                        case .min11:
                                            Text("개피")
                                        case .min16:
                                            Text("개피")
                                        case .min21:
                                            Text("갑 초과")
                                        }
                                    }
                                } else {
                                    Text("오늘은 흡연하지 않았어요!")
                                        .font(.footnote)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .smoking
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 흡연량")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                HStack(alignment: .bottom) {
                                    Text("-")
                                        .font(.largeTitle)
                                        .foregroundStyle(.pink)
                                        .bold()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .smoking
                            }
                        }
                        
                        // 음주량
                        if(isOnDrink == true) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 음주량")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                
                                    let drinkAmount = DrinkAmount.from(value: viewModel.amountOfAlcohol)
                                HStack(alignment: .bottom) {
                                    if viewModel.amountOfAlcohol > 0 {
                                        Text(drinkAmount.diaryValue)
                                            .font(.largeTitle)
                                            .foregroundStyle(.purple)
                                            .bold()
                                        switch drinkAmount {
                                        case .max1:
                                            Text("병 미만")
                                                .font(.body)
                                        case .max2:
                                            Text("병")
                                                .font(.body)
                                        case .max3:
                                            Text("병 초과")
                                                .font(.body)
                                        case .max0:
                                            Text("")
                                        }
                                    } else {
                                        HStack(alignment: .bottom) {
                                            Text("-")
                                                .font(.largeTitle)
                                                .foregroundStyle(.purple)
                                                .bold()
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .drink
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘의 음주량")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 9)
                                HStack(alignment: .bottom) {
                                    Text("-")
                                        .font(.largeTitle)
                                        .foregroundStyle(.purple)
                                        .bold()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                viewModel.isPresentedBottomSheet = true
                                viewModel.currentPage = .drink
                            }
                        }
                    }
                    
                    // 메모
                    VStack(alignment: .leading, spacing: 0) {
                        Text("메모")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom, 9)
                        Text(viewModel.memo)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .padding(16)
                            .background(.thoTextField)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        viewModel.isPresentedBottomSheet = true
                        viewModel.currentPage = .memo
                    }
                    
                    Text("각 항목을 터치하면 수정할 수 있습니다.")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
            }
            .background(.thoTextField)
            .sheet(isPresented: $isPresentedBottomSheet) {
                DiaryUpdateView(viewModel: viewModel)
            }
            .onAppear {
                
            }
        } else {
            ZStack {
                Color.thoTextField
                VStack(alignment: .center) {
                    Image("noneDiary")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 130)
                        .padding(.bottom, 20)
                    Text("기록된 항목이 없어요!")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

struct BarProgressStyle: ProgressViewStyle {
    
    var color: Color = .thoOrange
    var height: Double = 24.0
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.thoTextField)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                    }
            }
            
        }
    }
}


extension DiaryContentsView {
    func showModal(_ currentPage: DailyRecordPage) {
        isPresentedBottomSheet.toggle()
        viewModel.currentPage = currentPage
    }
}
#Preview {
    DiaryContentsView(viewModel: DiaryMainViewModel())
}
