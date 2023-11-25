//
//  TakenMedicine+CoreDataProperties.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/21/23.
//
//

import Foundation
import CoreData


extension TakenMedicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TakenMedicine> {
        return NSFetchRequest<TakenMedicine>(entityName: "TakenMedicine")
    }

    @NSManaged public var name: String?
    @NSManaged public var settingTime: Date?
    @NSManaged public var timeTaken: Date?
    @NSManaged public var capacity: String?
    @NSManaged public var unit: String?
    @NSManaged public var parentTakenMedicines: TakenMedicines?

}

extension TakenMedicine : Identifiable {

}
