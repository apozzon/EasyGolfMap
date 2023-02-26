//
//  Setup+CoreDataProperties.swift
//  EasyGolfMap
//
//  Created by Andrea Pozzoni on 05/04/21.
//
//

import Foundation
import CoreData


extension Setup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setup> {
        return NSFetchRequest<Setup>(entityName: "Setup")
    }

    @NSManaged public var yardsOrMeters: String?
    @NSManaged public var showThreeHoles: Bool
    @NSManaged public var freeMap: Bool
    @NSManaged public var userName: String?
    @NSManaged public var password: String?

}

extension Setup : Identifiable {

}
