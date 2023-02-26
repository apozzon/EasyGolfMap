//
//  Ranges+CoreDataClass.swift
//  User-Location
//
//  Created by Andrea Pozzoni on 23/03/21.
//
//

import Foundation
import CoreData

@objc(Ranges)
public class Ranges: NSManagedObject {
    /*
        Un oggetto NSManagedobject viene creato definito l'Entity di riferimento (cioè quella a cui è associata)
        e il NSManagedObjectContext in cui verrà salvato. L'NSManagedObjectContext è il contenitore di tutti gli oggetti NSManagedObject salvati.
    */
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        }
}
