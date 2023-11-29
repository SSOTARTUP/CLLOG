//
//  DiaryMainViewModel.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/20/23.
//

import Foundation
import SwiftUI
import CoreData

class DiaryMainViewModel: NSObject, RecordProtocol {
    
    private let coreDataManager = CoreDataManager.shared
    
    private let dayRecordsController: NSFetchedResultsController<DayRecords>
    private let takensController: NSFetchedResultsController<Takens>

    private let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    override init() {
        let fetchRequest: NSFetchRequest<DayRecords> = DayRecords.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DayRecords.date, ascending: true)]
//        fetchRequest.predicate = NSPredicate(format: "date == %@", Date() as CVarArg)

        dayRecordsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        let fetchTakensRequest: NSFetchRequest<Takens> = Takens.fetchRequest()
        fetchTakensRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Takens.date, ascending: true)]
//        let startDate = Calendar.current.startOfDay(for: Date())
//        fetchTakensRequest.predicate = NSPredicate(format: "date == %@", startDate as CVarArg)
        
        takensController = NSFetchedResultsController(
            fetchRequest: fetchTakensRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        dayRecordsController.delegate = self
        takensController.delegate = self

        
        do {
            try dayRecordsController.performFetch()
            try takensController.performFetch()

            status = initialize()
        } catch {
            print("Failed to fetch items: \(error)")
        }
        //calendar view 로직에 따라 주석이 해제될 수 있음.
    }
    
    @Published var selectedDate: Date = Date(){
        didSet{
            status = initialize()
        }
    }
    

    @AppStorage(UserDefaultsKey.dailyRecordPage.rawValue) var dailyRecordPages: String = [
        DailyRecordPage.condition,
        DailyRecordPage.mood,
        DailyRecordPage.sleeping,
        DailyRecordPage.sideEffect,
        DailyRecordPage.weightCheck,
        DailyRecordPage.menstruation,
        DailyRecordPage.encourage,
        DailyRecordPage.activity,
        DailyRecordPage.smoking,
        DailyRecordPage.caffein,
        DailyRecordPage.drink,
        DailyRecordPage.memo,
        DailyRecordPage.complete
    ].convertPageToString
    
    @Published var status: Status = .none
    
    @Published var closeAlert: Bool = false
    
    @Published var currentPage: DailyRecordPage = .condition
    
    @Published var answer: ConditionViewModel.ConditionAnswer = [:]
    @Published var userValues: [Double] = [0.0, 0.0, 0.0, 0.0]

    @Published var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    
    @Published var sleepingTime: Int = 0
    @Published var startAngle: Double = 0
    @Published var toAngle: Double = 180
    @Published var startProgress: CGFloat = 0
    @Published var toProgress: CGFloat = 0.5
    
    @Published var popularEffect: [SideEffects.Major] = [.none]
    
    @Published var dangerEffect: [SideEffects.Dangerous] = [.none]
    
    @Published var weight: Double = 50.0
    @Published var selectedKg: Int = 50
    @Published var selectedGr: Int = 0
    
    @Published var list: Activities = []

    @Published var amountOfSmoking = 0
    
    @Published var amountOfCaffein = 0
    
    @Published var isPeriod = false
    
    @Published var isSelected: [Bool] = Array(repeating: false, count: 10)
    @Published var isTaken: CaffeineIntake? = .not
    
    @Published var amountOfAlcohol = 0
    
    @Published var memo = ""
    
    @Published var pageNumber = 0
    
    // 캘린더 관련
    @Published var tempDate: Date = Date()

    @Published var medicines: [Medicine] = []
}

extension DiaryMainViewModel {
    // 캘린더 관련
    func openMonthly() {
        tempDate = selectedDate
    }
    
    func move() {
        selectedDate = tempDate
    }
    
    func bottomButtonClicked() {
        let dayRecord = DayRecord(
            date: Calendar.current.startOfDay(for: selectedDate), // 저장 시 현재 날짜 사용
            conditionValues: answer.map{ $0 }.sorted{ $0.key.rawValue < $1.key.rawValue }.map{ Double($0.value.rawValue) },
            moodValues: moodValues,
            sleepingTime: sleepingTime,
            popularEffect: popularEffect,
            dangerEffect: dangerEffect,
            weight: weight,
            acitivty: list,
            amountOfSmoking: amountOfSmoking,
            amountOfCaffein: amountOfCaffein,
            isPeriod: isPeriod,
            amountOfAlcohol: amountOfAlcohol,
            memo: memo
        )
        
        DayRecordsManager.shared.updateDayRecord(dayRecord)
    }
    
    func initialize() -> Status{
        print("DiaryMainViewModel 델리게이트 update")
        guard let record = DayRecordsManager.shared.fetchDayRecord(for: selectedDate) else {
            // 해당 날짜에 데일리 레코드가 없음.
            return .none
        }
        userValues = record.conditionValues
        moodValues = record.moodValues
        
        sleepingTime = record.sleepingTime
        
        popularEffect = record.popularEffect
        dangerEffect = record.dangerEffect
        
        list = record.acitivty

        weight = record.weight
        
        amountOfSmoking = record.amountOfSmoking
        
        amountOfCaffein = record.amountOfCaffein
        isTaken = amountOfCaffein == 0 ? .not : .intake
        
        isPeriod = record.isPeriod
        
        amountOfAlcohol = record.amountOfAlcohol
        
        memo = record.memo
        guard let history = TakensManager.shared.fetchHistory(date: selectedDate) else { return .error }
        
        var historyDic: [String: Medicine] = [:]
        history.forEach {
            if var hd = historyDic["\($0.name)|\($0.capacity)|\($0.unit)"]{
                hd.times += 1
                historyDic["\($0.name)|\($0.capacity)|\($0.unit)"] = hd
            } else {
                historyDic["\($0.name)|\($0.capacity)|\($0.unit)"] = Medicine(name: $0.name, capacity: $0.capacity, unit: $0.unit, times: 1)
            }
        }
        
        medicines = historyDic.map { $0.value }
        return .exist
    }
    
    enum Status {
        case none
        case exist
        case error
    }
}

extension DiaryMainViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        status = initialize()
    }
    
    struct Medicine {
        let name: String
        let capacity: String
        let unit: String
        var times: Int
    }
}
