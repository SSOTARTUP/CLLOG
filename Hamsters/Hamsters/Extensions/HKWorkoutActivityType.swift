//
//  HKWorkoutActivityType.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType{
    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "미식 축구"
        case .archery:                      return "양궁"
        case .australianFootball:           return "호주식 축구"
        case .badminton:                    return "배드민턴"
        case .baseball:                     return "야구"
        case .basketball:                   return "농구"
        case .bowling:                      return "볼링"
        case .boxing:                       return "복싱"
        case .climbing:                     return "등반"
        case .crossTraining:                return "크로스 트레이닝"
        case .curling:                      return "컬링"
        case .cycling:                      return "사이클링"
        case .dance:                        return "댄스"
        case .danceInspiredTraining:        return "댄스 영감 트레이닝"
        case .elliptical:                   return "엘립티컬"
        case .equestrianSports:             return "승마 스포츠"
        case .fencing:                      return "펜싱"
        case .fishing:                      return "낚시"
        case .functionalStrengthTraining:   return "기능성 힘 트레이닝"
        case .golf:                         return "골프"
        case .gymnastics:                   return "체조"
        case .handball:                     return "핸드볼"
        case .hiking:                       return "하이킹"
        case .hockey:                       return "하키"
        case .hunting:                      return "사냥"
        case .lacrosse:                     return "라크로스"
        case .martialArts:                  return "무술"
        case .mindAndBody:                  return "마음과 몸"
        case .mixedMetabolicCardioTraining: return "혼합 대사 심장 트레이닝"
        case .paddleSports:                 return "패들 스포츠"
        case .play:                         return "놀이"
        case .preparationAndRecovery:       return "회복"
        case .racquetball:                  return "라켓볼"
        case .rowing:                       return "조정"
        case .rugby:                        return "럭비"
        case .running:                      return "달리기"
        case .sailing:                      return "요트"
        case .skatingSports:                return "스케이팅 스포츠"
        case .snowSports:                   return "스노우 스포츠"
        case .soccer:                       return "축구"
        case .softball:                     return "소프트볼"
        case .squash:                       return "스쿼시"
        case .stairClimbing:                return "계단 오르기"
        case .surfingSports:                return "서핑 스포츠"
        case .swimming:                     return "수영"
        case .tableTennis:                  return "탁구"
        case .tennis:                       return "테니스"
        case .trackAndField:                return "육상"
        case .traditionalStrengthTraining:  return "힘 트레이닝"
        case .volleyball:                   return "배구"
        case .walking:                      return "걷기"
        case .waterFitness:                 return "수상 피트니스"
        case .waterPolo:                    return "수구"
        case .waterSports:                  return "수상 스포츠"
        case .wrestling:                    return "레슬링"
        case .yoga:                         return "요가"

        // iOS 10
        case .barre:                        return "바레"
        case .coreTraining:                 return "코어 트레이닝"
        case .crossCountrySkiing:           return "크로스컨트리 스키"
        case .downhillSkiing:               return "알파인 스키"
        case .flexibility:                  return "유연성"
        case .highIntensityIntervalTraining:    return "고강도 간헐적 트레이닝"
        case .jumpRope:                     return "줄넘기"
        case .kickboxing:                   return "킥복싱"
        case .pilates:                      return "필라테스"
        case .snowboarding:                 return "스노보딩"
        case .stairs:                       return "계단"
        case .stepTraining:                 return "스텝 트레이닝"
        case .wheelchairWalkPace:           return "휠체어 걷기 속도"
        case .wheelchairRunPace:            return "휠체어 달리기 속도"

        // iOS 11
        case .taiChi:                       return "태극권"
        case .mixedCardio:                  return "혼합 심장 운동"
        case .handCycling:                  return "핸드 사이클링"

        // iOS 13
        case .discSports:                   return "디스크 스포츠"
        case .fitnessGaming:                return "피트니스 게임"

        // Catch-all
        default:                            return "기타"
        }
    }
}


