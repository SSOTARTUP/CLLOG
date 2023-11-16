//
//  DayRecords+CoreDataProperties.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/16/23.
//
//

import Foundation
import CoreData


extension DayRecords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayRecords> {
        return NSFetchRequest<DayRecords>(entityName: "DayRecords")
    }

    @NSManaged public var amountOfAlcohol: Int16
    @NSManaged public var amountOfCaffein: Int16
    @NSManaged public var amountOfSmoking: Int16
    @NSManaged public var conditionValues: String?
    @NSManaged public var dangerEffect: String?
    @NSManaged public var isPeriod: Bool
    @NSManaged public var memo: String?
    @NSManaged public var moodValues: String?
    @NSManaged public var popularEffect: String?
    @NSManaged public var sleepingTime: Int16
    @NSManaged public var weight: Double
    @NSManaged public var date: Date?

}

extension DayRecords : Identifiable {

}
