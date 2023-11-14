//
//  Medicines+CoreDataProperties.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/13/23.
//
//

import Foundation
import CoreData

extension Medicines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicines> {
        return NSFetchRequest<Medicines>(entityName: "Medicines")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var capacity: String?
    @NSManaged public var unit: String?
    @NSManaged public var frequency: Data?
    @NSManaged public var alarms: Data?
    @NSManaged public var freOption: String?
    @NSManaged public var sortedDays: String?

}

extension Medicines : Identifiable {

}
