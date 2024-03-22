//
//  Good+CoreDataProperties.swift
//  FairDivision
//
//  Created by Srikar on 3/14/24.
//
//

import Foundation
import CoreData


extension Good {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Good> {
        return NSFetchRequest<Good>(entityName: "Good")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Good : Identifiable {

}
