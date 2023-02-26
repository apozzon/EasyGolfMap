//  CoreDataController.swift
//
//
//
//

import Foundation
import CoreData
import UIKit


/*
    La classe CoreDataController è stata creata con l'unico scopo di velocizzare l'interazione con le funzioni del Core Data.
    Qui dentro troverai le funzioni necessarie al salvataggio, eliminazione ecc degli elementi salvati in memoria.
*/

class CoreDataController {
    static let shared = CoreDataController() // proprietà per ottenere la classe in modalità Singleton
    
    private var context: NSManagedObjectContext // riferimento al contenitore degli oggetti (ManagedObject) salvati in memoria
    
    private init() {
        let application = UIApplication.shared.delegate as! AppDelegate // recupero l'istanza dell'AppDelegate dell'applicazione
        self.context = application.persistentContainer.viewContext // recupero il ManagedObjectContext dalla proprietà persistantContainer presente nell'App Delegate
    }
 
    func loadSetup() -> [Setup] {
        let request: NSFetchRequest<Setup> = NSFetchRequest(entityName: "Setup") // l'oggetto rappresenta una richiesta da inviare al context per la ricerca di oggetti di tipo entityName (nome dell'entity da cercare)
        request.returnsObjectsAsFaults = false
        
        let setup = self.loadSetupFromFetchRequest(request: request)
        return setup
    }
    
    private func loadSetupFromFetchRequest(request: NSFetchRequest<Setup>) -> [Setup] {
        var array = [Setup]()
        do {
            array = try self.context.fetch(request)
            
            guard array.count > 0 else {print("[CDC] No elements to read. "); return []}
            
        } catch let error {
            print("[CDC] Problem performingnFetchRequest.")
            print("  Printing the error: \n \(error) .\n")
        }
        
        return array
    }
    
    func deleteSetup() {
        // delete previous setup data, only the last remains into memory
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Setup")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            // Error Handling
        }
    }
    
    
    func saveSetup(uOm: String, freeMap: Bool, show3Holes: Bool, userName: String, password: String) {
        
        // delete previous setup data
        deleteSetup()
        // save the new setup
        let entity = NSEntityDescription.entity(forEntityName: "Setup", in: self.context)
        let setup = Setup(entity: entity!, insertInto: self.context)
        setup.yardsOrMeters = uOm
        setup.freeMap = freeMap
        setup.showThreeHoles = show3Holes
        setup.userName = userName
        setup.password = password
        do {
            try self.context.save() // la funzione save() rende persistente il nuovo oggetto (newRange) in memoria
        } catch let error {
            print("[CDC] Problem saving in memory: \(String(describing: setup.yardsOrMeters)) .")
            print("  Printing error \n \(error) .\n")
        }
        }
    
    func setupExist() -> Int {
        let request: NSFetchRequest<Setup> = NSFetchRequest(entityName: "Setup")
        request.returnsObjectsAsFaults = false
        
        let setup = self.loadSetupFromFetchRequest(request: request)
        return setup.count
        
    }
    
    func addCourse(name: String,
                   desc: String,
                   h01la: Double,
                   h01lo: Double,
                   h02la: Double,
                   h02lo: Double,
                   h03la: Double,
                   h03lo: Double,
                   h04la: Double,
                   h04lo: Double,
                   h05la: Double,
                   h05lo: Double,
                   h06la: Double,
                   h06lo: Double,
                   h07la: Double,
                   h07lo: Double,
                   h08la: Double,
                   h08lo: Double,
                   h09la: Double,
                   h09lo: Double,
                   h10la: Double,
                   h10lo: Double,
                   h11la: Double,
                   h11lo: Double,
                   h12la: Double,
                   h12lo: Double,
                   h13la: Double,
                   h13lo: Double,
                   h14la: Double,
                   h14lo: Double,
                   h15la: Double,
                   h15lo: Double,
                   h16la: Double,
                   h16lo: Double,
                   h17la: Double,
                   h17lo: Double,
                   h18la: Double,
                   h18lo: Double)
    {
        /*
            Per creare un oggetto da inserire in memoria è necessario creare un riferimento all'Entity (NSEntityDescription) da cui si copierà la struttura di base
         */
        let entity = NSEntityDescription.entity(forEntityName: "Ranges", in: self.context)
        
        /*
            creiamo un nuovo oggetto NSManagedObject dello stesso tipo descritto dalla NSEntityDescription
            che andrà inserito nel context dell'applicazione
         */
        let newCourse = Ranges(entity: entity!, insertInto: self.context)
        
        newCourse.name = name
        newCourse.desc = desc
        newCourse.h01la = h01la
        newCourse.h01lo = h01lo
        newCourse.h02la = h02la
        newCourse.h02lo = h02lo
        newCourse.h03la = h03la
        newCourse.h03lo = h03lo
        newCourse.h04la = h04la
        newCourse.h04lo = h04lo
        newCourse.h05la = h05la
        newCourse.h05lo = h05lo
        newCourse.h06la = h06la
        newCourse.h06lo = h06lo
        newCourse.h07la = h07la
        newCourse.h07lo = h07lo
        newCourse.h08la = h08la
        newCourse.h08lo = h08lo
        newCourse.h09la = h09la
        newCourse.h09lo = h09lo
        newCourse.h10la = h10la
        newCourse.h10lo = h10lo
        newCourse.h11la = h11la
        newCourse.h11lo = h11lo
        newCourse.h12la = h12la
        newCourse.h12lo = h12lo
        newCourse.h13la = h13la
        newCourse.h13lo = h13lo
        newCourse.h14la = h14la
        newCourse.h14lo = h14lo
        newCourse.h15la = h15la
        newCourse.h15lo = h15lo
        newCourse.h16la = h16la
        newCourse.h16lo = h16lo
        newCourse.h17la = h17la
        newCourse.h17lo = h17lo
        newCourse.h18la = h18la
        newCourse.h18lo = h18lo
        
        do {
            try self.context.save() // la funzione save() rende persistente il nuovo oggetto (newRange) in memoria
        } catch let error {
            print("[CDC] Problem saving in memory: \(newCourse.name!) .")
            print("  Printing error \n \(error) .\n")
        }

    }
    
    /*
        La funzione carica e stampa in console tutti i golf presenti nella memoria
     */
    func loadAllCourses() -> [Ranges] {
        
        let request: NSFetchRequest<Ranges> = NSFetchRequest(entityName: "Ranges") // l'oggetto rappresenta una richiesta da inviare al context per la ricerca di oggetti di tipo entityName (nome dell'entity da cercare)
        request.returnsObjectsAsFaults = false
        
        let courses = self.loadCoursesFromFetchRequest(request: request)
        
        return courses
    }
    
    
    func loadCoursesFromName(name: String) -> [Ranges]{
        
        let request: NSFetchRequest<Ranges> = NSFetchRequest(entityName: "Ranges")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "name = %@", name) // L'oggetto predicate permette di aggiungere dei filtri sulla NSFetchRequest
        request.predicate = predicate
        
        let ranges = self.loadCoursesFromFetchRequest(request: request)
        
        return ranges
    }
    
    /*
      La funzione restituisce un array di ranges dopo aver eseguito la request
    */
    private func loadCoursesFromFetchRequest(request: NSFetchRequest<Ranges>) -> [Ranges] {
        var array = [Ranges]()
        do {
            array = try self.context.fetch(request)
            
            guard array.count > 0 else {print("[CDC] No elements to read. "); return []}
            
        } catch let error {
            print("[CDC] Problem performingnFetchRequest.")
            print("  Printing the error: \n \(error) .\n")
        }
        
        return array
    }
    
    /*
     La funzione recupera il driving range che ha lo stesso nome del parametro "name" (qualora esistesse)
     */
    func loadCourseFromName(name: String) -> Ranges {

        let request: NSFetchRequest<Ranges> = NSFetchRequest(entityName: "Ranges")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        let ranges = self.loadCoursesFromFetchRequest(request: request)

        return ranges[0]
    }
    
    func countFromName(name: String) -> Int {
        let request: NSFetchRequest<Ranges> = NSFetchRequest(entityName: "Ranges")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        let ranges = self.loadCoursesFromFetchRequest(request: request)
        let cnt = ranges.count  // number of occurencies found


        return cnt
        
    }
    
    func countCourses() -> Int {
        let request: NSFetchRequest<Ranges> = NSFetchRequest(entityName: "Ranges")
        request.returnsObjectsAsFaults = false
        
        let courses = self.loadCoursesFromFetchRequest(request: request)
        return courses.count
        
    }
 
    /*
        La funzione cancella dalla memoria il range che ha per nome il paramentro "name"
     */
    func deleteCourse(name: String) -> String{
        
        let found = self.countFromName(name: name)
        if (found == 0){
            
            return "Range not found"
            
        }
        else {
            
            let course = self.loadCourseFromName(name: name)
            
            self.context.delete(course)
            
        }
        return "Deleted"
    }
    
    func deleteAll() {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ranges")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try context.save()

        } catch {
            // Error Handling
            // ...
        }
        
    }
}
