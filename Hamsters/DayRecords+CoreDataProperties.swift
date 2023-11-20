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
    @NSManaged public var conditionValues: Data?
    @NSManaged public var dangerEffect: Data?
    @NSManaged public var isPeriod: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var memo: String?
    @NSManaged public var moodValues: Data?
    @NSManaged public var popularEffect: Data?
    @NSManaged public var sleepingTime: Int16
    @NSManaged public var weight: Double
    @NSManaged public var date: Date?

}

extension DayRecords : Identifiable {

}
