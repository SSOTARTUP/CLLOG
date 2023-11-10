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

    private init() { }

    // HealthKit 권한 요청 메서드
    func requestAuthorization() {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(),
            HKSeriesType.workoutRoute(),
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if !success {
                // Handle the error here.
                print("Authorization to access HealthKit data was denied or an error occurred: \(String(describing: error))")
                
            }
            self.fetchSleepData { sample, error in
         //       print(sample)
                sample?.forEach{
                    print($0.startDate.timeIntervalSince1970,"timeInterval")
                    print(self.convertTimeIntervalToKoreanTime(timeInterval: $0.startDate.timeIntervalSince1970))
                }
            }
//            self.fetchWorkouts { sample, error in
//                
//                sample?.forEach { HKWorkout in
//                    print("startDate",HKWorkout.startDate)
//                    print("duration",HKWorkout.duration)
//                    print("name",HKWorkout.workoutActivityType.name)
//                    print("workout",HKWorkout.workoutActivities)
//                }
//            }

        }
    }

    // 운동 데이터 조회 메서드
    func fetchWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let from = Calendar.current.date(byAdding: .day, value: -100, to: Date())
        let to = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: from, end: to)
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
extension HealthKitManager {
    func fetchSleepData(completion: @escaping ([HKSample]?, Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let yesterday = Calendar.current.date(byAdding: .day, value: -100, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: Date())
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            completion(samples, error)
        }
        
        healthStore.execute(query)
    }
}

extension HealthKitManager{
    func convertTimeIntervalToKoreanTime(timeInterval: TimeInterval) -> Date {
        let date = Date(timeIntervalSince1970: timeInterval)

        guard let koreanTimeZone = TimeZone(abbreviation: "KST") else {
            fatalError("Korean Time Zone not found")
        }

        return date.addingTimeInterval(TimeInterval(koreanTimeZone.secondsFromGMT(for: date)))
    }
}
