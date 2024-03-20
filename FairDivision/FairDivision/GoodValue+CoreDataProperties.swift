//
//  GoodValue+CoreDataProperties.swift
//  FairDivision
//
//  Created by Srikar on 3/14/24.
//
//

import Foundation
import CoreData


extension GoodValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoodValue> {
        return NSFetchRequest<GoodValue>(entityName: "GoodValue")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var good: Good?

}

extension GoodValue : Identifiable {

}
