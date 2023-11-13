//
//  HealthKitManager.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    static let shared = HealthKitManager()
    
    let healthStore = HKHealthStore()

    private init() {}
    
    enum Predicate{
        case yesterday
        case today
    }
}


//MARK: 권한
extension HealthKitManager {
    func requestAuthorization() {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(),
//            HKSeriesType.workoutRoute(),
//            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKObjectType.quantityType(forIdentifier: .heartRate)!,
//            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)! // 수면은 이거 하나면 됨
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if !success {
                // Handle the error here.
                print("Authorization to access HealthKit data was denied or an error occurred: \(String(describing: error))")
            }
        }
    }
}


//MARK: 운동 데이터
extension HealthKitManager {
    
    func fetchWorkouts(_ predicate:Predicate,completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let calendar = Calendar.current

        let startOfToday = calendar.startOfDay(for: Date())
        let startOfYesterday = calendar.date(byAdding: .day, value: -1, to: startOfToday)!
        
        let predicate = switch predicate {
        case .yesterday: HKQuery.predicateForSamples(withStart: startOfYesterday, end: startOfToday)
        case .today  : HKQuery.predicateForSamples(withStart: startOfToday, end: Date())
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: workoutType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { query, samples, error in
            guard let workouts = samples as? [HKWorkout], error == nil else {
                completion(nil, error)
                return
            }
            completion(workouts, nil)
        }
        healthStore.execute(query)
    }
    
}


//MARK: 수면 데이터
extension HealthKitManager {
    
    func fetchSleepData(_ predicate:Predicate,completion: @escaping (Date?, Date?, TimeInterval?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, nil, nil)
            return
        }
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
    //    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard error == nil, let sleepSamples = samples as? [HKCategorySample], !sleepSamples.isEmpty else {
                completion(nil, nil, nil)
                return
            }
            
            let firstSleepStart = sleepSamples.first?.startDate
            let lastSleepEnd = sleepSamples.last?.endDate
            let totalSleepTime = sleepSamples.reduce(0) { (result, sample) -> TimeInterval in
                return result + sample.endDate.timeIntervalSince(sample.startDate)
            }
            
            completion(firstSleepStart?.KST, lastSleepEnd?.KST, totalSleepTime)
        }
        
        healthStore.execute(query)
    }

    
    func fetchSleepDataRaw(completion: @escaping ([HKSample]?, Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: Date())
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            completion(samples, error)
        }
        
        healthStore.execute(query)
    }
}
