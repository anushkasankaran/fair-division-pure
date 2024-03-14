//
//  Agent+CoreDataProperties.swift
//  FairDivision
//
//  Created by Srikar on 3/13/24.
//
//

import Foundation
import CoreData


extension Agent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Agent> {
        return NSFetchRequest<Agent>(entityName: "Agent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var goods: NSSet?

}

// MARK: Generated accessors for goods
extension Agent {

    @objc(addGoodsObject:)
    @NSManaged public func addToGoods(_ value: GoodValue)

    @objc(removeGoodsObject:)
    @NSManaged public func removeFromGoods(_ value: GoodValue)

    @objc(addGoods:)
    @NSManaged public func addToGoods(_ values: NSSet)

    @objc(removeGoods:)
    @NSManaged public func removeFromGoods(_ values: NSSet)

}

extension Agent : Identifiable {

}
