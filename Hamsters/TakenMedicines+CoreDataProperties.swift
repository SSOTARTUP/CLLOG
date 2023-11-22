//
//  TakenMedicines+CoreDataProperties.swift
//  Hamsters
//
//  Created by YU WONGEUN on 11/21/23.
//
//

import Foundation
import CoreData


extension TakenMedicines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TakenMedicines> {
        return NSFetchRequest<TakenMedicines>(entityName: "TakenMedicines")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var takenMedicines: NSSet?

}

// MARK: Generated accessors for takenMedicines
extension TakenMedicines {

    @objc(addTakenMedicinesObject:)
    @NSManaged public func addToTakenMedicines(_ value: TakenMedicine)

    @objc(removeTakenMedicinesObject:)
    @NSManaged public func removeFromTakenMedicines(_ value: TakenMedicine)

    @objc(addTakenMedicines:)
    @NSManaged public func addToTakenMedicines(_ values: NSSet)

    @objc(removeTakenMedicines:)
    @NSManaged public func removeFromTakenMedicines(_ values: NSSet)

}

extension TakenMedicines : Identifiable {

}
