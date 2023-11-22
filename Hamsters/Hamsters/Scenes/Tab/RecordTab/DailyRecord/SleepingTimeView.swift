//
//  SleepingTimeView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/23/23.
//

import SwiftUI

struct SleepingTimeView<T: RecordProtocol>: View {
    @ObservedObject var viewModel: T
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a" // 이 형식은 'AM'/'PM'을 포함합니다.
        formatter.amSymbol = "AM" // 또는 원하는 다른 문자로 교체 가능
        formatter.pmSymbol = "PM" // 또는 원하는 다른 문자로 교체 가능
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let _ = viewModel as? DailyRecordViewModel {
                    Text("얼마나 주무셨나요?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                }
                HStack {
                    VStack(spacing: 0) {
                        Text("취침 시간")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        Text(timeFormatter.string(from: getTime(angle: viewModel.startAngle)))
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.thoNavy)
                            .monospacedDigit()
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("기상 시간")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        Text(timeFormatter.string(from: getTime(angle: viewModel.toAngle)))
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.thoNavy)
                            .monospacedDigit()
                            .frame(maxWidth: .infinity) // 이 줄이 추가되었습니다.
                    }
                   
                }
                .padding(.horizontal, 48)
                
                VStack {
                    SleepTimeSlider()
                        .padding(.vertical, 20)
                        .padding(.bottom, 16)
                    

                    VStack(spacing: 0) {
                        Text("총 수면시간")
                            .font(.footnote)
                            .foregroundStyle(.white)
                        
                        Text("\(getTimeDifference().0)시간 \(getTimeDifference().1)분" )
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.thoGreen)  // 텍스트의 색상을 지정합니다. 이 경우 흰색을 사용했습니다.
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)  // 텍스트 주변에 패딩을 추가합니다.
                    .background {
                        Capsule()  // 캡슐 형태의 배경을 추가합니다.
                            .foregroundStyle(.thoNavy)  // 캡슐의 색상을 지정합니다. 여기서는 원하는 색상을 선택하세요.
                    }
                    .padding(.horizontal, 104)
                }
                
                Spacer()
                
                Button {
                    viewModel.sleepingTime = (getTimeDifference().0 * 60) + getTimeDifference().1
                    viewModel.bottomButtonClicked()

                } label: {
                    Text("다음")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(.thoNavy)
                        .cornerRadius(15)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 30)
            }
            
        }
    }
    
    // MARK: - SleepTimeCircluarSlider
    @ViewBuilder
    func SleepTimeSlider() -> some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width
            let height = proxy.size.height
            
            ZStack {
                ZStack {
                    ForEach(1...60, id: \.self) { index in
                        Rectangle()
                            .fill(.black)
                            .frame(width: 2, height: index % 5 == 0 ? 15 : 5)
                            .offset(y: (width - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 6))
                    }
                    
                    let texts = ["6AM", "12PM", "6PM", "12AM"]
                    ForEach(texts.indices, id: \.self) { index in
                        // 각 레이블에 대한 각도를 계산합니다. (360도 / 레이블 개수 * 현재 인덱스)
                        let angleDegree = Double(index) * (360.0 / Double(texts.count))
                        
                        // 위에서 계산한 각도로부터 라디안을 계산합니다.
                        let angleRadian = angleDegree * .pi / 180.0
                        
                        // 원의 중심으로부터 레이블을 배치할 x, y 위치를 계산합니다.
                        let xPosition = CGFloat(width / 2.0 - 60.0) * cos(CGFloat(angleRadian)) // 적절한 값을 조정하여 위치 변경 가능
                        let yPosition = CGFloat(width / 2.0 - 60.0) * sin(CGFloat(angleRadian)) // 적절한 값을 조정하여 위치 변경 가능
                        
                        // 계산된 위치에 텍스트 레이블을 배치합니다.
                        Text("\(texts[index])")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .position(x: width / 2 + xPosition, y: height / 2 + yPosition)
                    }
                }
                
                Circle()
                    .stroke(Color.thoDisabled, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .shadow(radius: 5)
                
                let reverseRotation = (viewModel.startProgress > viewModel.toProgress) ? -Double((1 - viewModel.startProgress) * 360) : 0
                
                Circle()
                    .trim(from: viewModel.startProgress > viewModel.toProgress ? 0 : viewModel.startProgress, to: viewModel.toProgress + (-reverseRotation / 360))
                    .stroke(Color.thoNavy, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                
                Image(systemName: "bed.double.fill")
                    .font(.title)
                    .foregroundStyle(.thoNavy)
                
                // Slider Button
                Image(systemName: "moon.stars.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -viewModel.startAngle))
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: viewModel.startAngle))
                    .gesture(
                        
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value, fromSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                Image(systemName: "sun.max.fill")
                    .font(.title2)
                    .foregroundStyle(.yellow)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -viewModel.toAngle))
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: viewModel.toAngle))
                    .gesture(
                        
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
            }
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        // 위치를 기반으로 벡터를 계산합니다.
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        // 벡터를 사용하여 라디안 값을 구합니다.
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // 라디안을 각도로 변환합니다.
        var angle = radians * 180 / .pi
        // 각도가 음수인 경우 보정합니다.
        if angle < 0 { angle = 360 + angle }
        
        // 각도를 분으로 변환 (360도 = 24시간 = 1440분).
        let totalMinutes = (angle / 360) * 1440
        
        // 가장 가까운 5분 단위로 반올림합니다.
        let roundedMinutes = (totalMinutes / 5).rounded() * 5
        
        // 반올림된 분을 각도로 다시 변환합니다.
        let roundedAngle = (roundedMinutes / 1440) * 360
        
        // 각도로 진행 상태를 계산합니다.
        let progress = roundedAngle / 360
        
        if fromSlider {
            viewModel.startAngle = roundedAngle
            viewModel.startProgress = progress
        } else {
            viewModel.toAngle = roundedAngle
            viewModel.toProgress = progress
        }
    }
    
    
    func getTime(angle: Double) -> Date {
        // 360도를 기준으로 비율을 계산하여 전체 분으로 변환합니다. (24시간 * 60분 = 1440분)
        let totalMinutes = (angle / 360) * 1440
        
        // 총 분을 시간과 분으로 분리합니다.
        let hours = Int(totalMinutes) / 60
        let minutes = Int(totalMinutes) % 60
        
        // 현재 날짜에서 시간과 분을 설정합니다.
        if let date = Calendar.current.date(bySettingHour: hours, minute: minutes, second: 0, of: Date()) {
            return date
        }
        
        // 예외 상황에 대비하여 현재 시간을 반환합니다.
        return Date()
    }
    
    func getTimeDifference() -> (Int, Int) {
        let startDate = getTime(angle: viewModel.startAngle)
        let endDate = getTime(angle: viewModel.toAngle)
        
        // 날짜 계산을 위한 캘린더를 사용하여 시간과 분을 추출합니다.
        let components = Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
        
        var hours = components.hour ?? 0
        var minutes = components.minute ?? 0
        
        // 분이 음수인 경우 처리: 시간에서 1을 빼고, 분에 60을 더합니다.
        if minutes < 0 {
            hours -= 1  // 시간에서 1 빼기
            minutes += 60  // 분에 60 더하기 (음수를 양수로 변환)
        }
        
        // 시간 차이가 음수인 경우 처리 (다음 날로 넘어감), 24시간을 더하여 조정합니다.
        if hours < 0 {
            hours += 24  // 음수인 경우 24시간 더하기
        }
        
        return (hours, minutes)
    }
    
}

#Preview {
    SleepingTimeView(viewModel: DailyRecordViewModel())
}
