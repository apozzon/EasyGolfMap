//
//  Ranges+CoreDataProperties.swift
//  User-Location
//
//  Created by Andrea Pozzoni on 24/03/21.
//
//

import Foundation
import CoreData


extension Ranges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ranges> {
        return NSFetchRequest<Ranges>(entityName: "Ranges")
    }
    //@NSManaged indica che la variabile è stata creata per rappresentare l’attributo presente nell’Entity generica "Ranges" che potrà creare oggetti specifici "range"
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var h01la: Double
    @NSManaged public var h01lo: Double
    @NSManaged public var h02la: Double
    @NSManaged public var h02lo: Double
    @NSManaged public var h03la: Double
    @NSManaged public var h03lo: Double
    @NSManaged public var h04la: Double
    @NSManaged public var h04lo: Double
    @NSManaged public var h05la: Double
    @NSManaged public var h05lo: Double
    @NSManaged public var h06la: Double
    @NSManaged public var h06lo: Double
    @NSManaged public var h07la: Double
    @NSManaged public var h07lo: Double
    @NSManaged public var h08la: Double
    @NSManaged public var h08lo: Double
    @NSManaged public var h09la: Double
    @NSManaged public var h09lo: Double
    @NSManaged public var h10la: Double
    @NSManaged public var h10lo: Double
    @NSManaged public var h11la: Double
    @NSManaged public var h11lo: Double
    @NSManaged public var h12la: Double
    @NSManaged public var h12lo: Double
    @NSManaged public var h13la: Double
    @NSManaged public var h13lo: Double
    @NSManaged public var h14la: Double
    @NSManaged public var h14lo: Double
    @NSManaged public var h15la: Double
    @NSManaged public var h15lo: Double
    @NSManaged public var h16la: Double
    @NSManaged public var h16lo: Double
    @NSManaged public var h17la: Double
    @NSManaged public var h17lo: Double
    @NSManaged public var h18la: Double
    @NSManaged public var h18lo: Double


}

extension Ranges : Identifiable {
//  Identifiable  vuol dire che gli oggetti creati saranno immutabili
}
