//
//  RecordProtocol.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/20/23.
//
import Foundation

protocol RecordProtocol: ObservableObject {

    var closeAlert: Bool { get set }
    
    var currentPage: DailyRecordPage { get set }
    
    var answer: ConditionViewModel.ConditionAnswer { get set }
    
    var moodValues: [Double] { get set }
    
    var sleepingTime: Int { get set }
    var startAngle: Double { get set }
    var toAngle: Double { get set }
    var startProgress: CGFloat { get set }
    var toProgress: CGFloat { get set }
    
    var popularEffect: [SideEffects.Major] { get set }
    
    var dangerEffect: [SideEffects.Dangerous] { get set }
    
    var weight: Double { get set }
    var selectedKg: Int { get set }
    var selectedGr: Int { get set }
    
    var amountOfSmoking: Int { get set }
    
    var amountOfCaffein: Int { get set }
    
    var isPeriod: Bool { get set }
    
    var isSelected: [Bool] { get set }
    var isTaken: CaffeineIntake? { get set }
    
    var amountOfAlcohol: Int { get set }
    
    var memo: String { get set }
    
    var pageNumber: Int { get set }

    func bottomButtonClicked() 
}
