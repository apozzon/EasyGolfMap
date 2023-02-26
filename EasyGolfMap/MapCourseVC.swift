//
//  MapCourseVC.swift
//  EasyGolfMap
//
//  Created by Andrea Pozzoni on 03/04/21.
//

import UIKit
import MapKit
import CoreLocation
import SwiftUI


class MapCourseVC: UIViewController, CLLocationManagerDelegate, UITableViewDelegate{
    
    let locationManager = CLLocationManager()
    
    // previous locations are used to average the set point of the hole. If the distance of the new measure from the previous is less than 8 meters, the new point is calculated as average of the current location and the previous one. Pushing the hole button severl times, the set point is set in the best possible way.

    var prevLa = hLat
    var prevLo = hLong

    
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseDescr: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var h1d: UIButton!
    @IBOutlet weak var h2d: UIButton!
    @IBOutlet weak var h3d: UIButton!
    @IBOutlet weak var h4d: UIButton!
    @IBOutlet weak var h5d: UIButton!
    @IBOutlet weak var h6d: UIButton!
    @IBOutlet weak var h7d: UIButton!
    @IBOutlet weak var h8d: UIButton!
    @IBOutlet weak var h9d: UIButton!
    @IBOutlet weak var h10d: UIButton!
    @IBOutlet weak var h11d: UIButton!
    @IBOutlet weak var h12d: UIButton!
    @IBOutlet weak var h13d: UIButton!
    @IBOutlet weak var h14d: UIButton!
    @IBOutlet weak var h15d: UIButton!
    @IBOutlet weak var h16d: UIButton!
    @IBOutlet weak var h17d: UIButton!
    @IBOutlet weak var h18d: UIButton!
    
    
    
    /*-----------------------------------------------------------
     // This functions (h01 to h18) enter the new pin location, save it and recalculate the distances to holes. When a hole is mapped pushing the correspondent button, the routine checks if there is already a previous pin position in a range of 8 meters (0.00006° lat and the same divided by the cosinus of the longitude for long), if yes an average is recalculated and saved. This will reduce the imprecision of the GPS that can be more than 4m
     */
    
    @IBAction func h01(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[1] = here.coordinate.latitude
        hLong[1] = here.coordinate.longitude
        if(abs(hLat[1] - prevLa[1]) < 6.0e-05 && abs(hLong[1] - prevLo[1]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[1] = (hLat[1] + prevLa[1]) / 2 ; hLong[1] = (hLong[1] + prevLo[1]) / 2 }
        prevLa[1] = hLat[1]
        prevLo[1] = hLong[1]
        messageLabel.text = "\(hLat[1]) - \(hLong[1])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h02(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[2] = here.coordinate.latitude
        hLong[2] = here.coordinate.longitude
        if(abs(hLat[2] - prevLa[2]) < 6.0e-05 && abs(hLong[2] - prevLo[2]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[2] = (hLat[2] + prevLa[2]) / 2 ; hLong[2] = (hLong[2] + prevLo[2]) / 2 }
        prevLa[2] = hLat[2]
        prevLo[2] = hLong[2]
        messageLabel.text = "\(hLat[2]) - \(hLong[2])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h03(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[3] = here.coordinate.latitude
        hLong[3] = here.coordinate.longitude
        if(abs(hLat[3] - prevLa[3]) < 6.0e-05 && abs(hLong[3] - prevLo[3]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[3] = (hLat[3] + prevLa[3]) / 2 ; hLong[3] = (hLong[3] + prevLo[3]) / 2 }
        prevLa[3] = hLat[3]
        prevLo[3] = hLong[3]
        messageLabel.text = "\(hLat[3]) - \(hLong[3])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h04(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[4] = here.coordinate.latitude
        hLong[4] = here.coordinate.longitude
        if(abs(hLat[4] - prevLa[4]) < 6.0e-05 && abs(hLong[4] - prevLo[4]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[4] = (hLat[4] + prevLa[4]) / 2 ; hLong[4] = (hLong[4] + prevLo[4]) / 2 }
        prevLa[4] = hLat[4]
        prevLo[4] = hLong[4]
        messageLabel.text = "\(hLat[4]) - \(hLong[4])"
        calculateAllDistances()
        saveFullcourse()
    }
    

    @IBAction func h05(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[5] = here.coordinate.latitude
        hLong[5] = here.coordinate.longitude
        if(abs(hLat[5] - prevLa[5]) < 6.0e-05 && abs(hLong[5] - prevLo[5]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[5] = (hLat[5] + prevLa[5]) / 2 ; hLong[5] = (hLong[5] + prevLo[5]) / 2 }
        prevLa[5] = hLat[5]
        prevLo[5] = hLong[5]
        messageLabel.text = "\(hLat[5]) - \(hLong[5])"
        calculateAllDistances()
        saveFullcourse()
    }

    @IBAction func h06(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[6] = here.coordinate.latitude
        hLong[6] = here.coordinate.longitude
        if(abs(hLat[6] - prevLa[6]) < 6.0e-05 && abs(hLong[6] - prevLo[6]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[6] = (hLat[6] + prevLa[6]) / 2 ; hLong[6] = (hLong[6] + prevLo[6]) / 2 }
        prevLa[6] = hLat[6]
        prevLo[6] = hLong[6]
        messageLabel.text = "\(hLat[6]) - \(hLong[6])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h07(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[7] = here.coordinate.latitude
        hLong[7] = here.coordinate.longitude
        if(abs(hLat[7] - prevLa[7]) < 6.0e-05 && abs(hLong[7] - prevLo[7]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[7] = (hLat[7] + prevLa[7]) / 2 ; hLong[7] = (hLong[7] + prevLo[7]) / 2 }
        prevLa[7] = hLat[7]
        prevLo[7] = hLong[7]
        messageLabel.text = "\(hLat[7]) - \(hLong[7])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h08(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[8] = here.coordinate.latitude
        hLong[8] = here.coordinate.longitude
        if(abs(hLat[8] - prevLa[8]) < 6.0e-05 && abs(hLong[8] - prevLo[8]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[8] = (hLat[8] + prevLa[8]) / 2 ; hLong[8] = (hLong[8] + prevLo[8]) / 2 }
        prevLa[8] = hLat[8]
        prevLo[8] = hLong[8]
        messageLabel.text = "\(hLat[8]) - \(hLong[8])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h09(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[9] = here.coordinate.latitude
        hLong[9] = here.coordinate.longitude
        if(abs(hLat[9] - prevLa[9]) < 6.0e-05 && abs(hLong[9] - prevLo[9]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[9] = (hLat[9] + prevLa[9]) / 2 ; hLong[9] = (hLong[9] + prevLo[9]) / 2 }
        prevLa[9] = hLat[9]
        prevLo[9] = hLong[9]
        messageLabel.text = "\(hLat[9]) - \(hLong[9])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h10(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[10] = here.coordinate.latitude
        hLong[10] = here.coordinate.longitude
        if(abs(hLat[10] - prevLa[10]) < 6.0e-05 && abs(hLong[10] - prevLo[10]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[10] = (hLat[10] + prevLa[10]) / 2 ; hLong[10] = (hLong[10] + prevLo[10]) / 2 }
        prevLa[10] = hLat[10]
        prevLo[10] = hLong[10]
        messageLabel.text = "\(hLat[10]) - \(hLong[10])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h11(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[11] = here.coordinate.latitude
        hLong[11] = here.coordinate.longitude
        if(abs(hLat[11] - prevLa[11]) < 6.0e-05 && abs(hLong[11] - prevLo[11]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[11] = (hLat[11] + prevLa[11]) / 2 ; hLong[11] = (hLong[11] + prevLo[11]) / 2 }
        prevLa[11] = hLat[11]
        prevLo[11] = hLong[11]
        messageLabel.text = "\(hLat[11]) - \(hLong[11])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h12(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[12] = here.coordinate.latitude
        hLong[12] = here.coordinate.longitude
        if(abs(hLat[12] - prevLa[12]) < 6.0e-05 && abs(hLong[12] - prevLo[12]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[12] = (hLat[12] + prevLa[12]) / 2 ; hLong[12] = ((hLong[12] + prevLo[12])/2)}
        prevLa[12] = hLat[12]
        prevLo[12] = hLong[12]
        messageLabel.text = "\(hLat[12]) - \(hLong[12])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h13(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[13] = here.coordinate.latitude
        hLong[13] = here.coordinate.longitude
        if(abs(hLat[13] - prevLa[13]) < 6.0e-05 && abs(hLong[13] - prevLo[13]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[13] = (hLat[13] + prevLa[13]) / 2 ; hLong[13] = ((hLong[13] + prevLo[13])/2)}
        prevLa[13] = hLat[13]
        prevLo[13] = hLong[13]
        messageLabel.text = "\(hLat[13]) - \(hLong[13])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h14(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[14] = here.coordinate.latitude
        hLong[14] = here.coordinate.longitude
        if(abs(hLat[14] - prevLa[14]) < 6.0e-05 && abs(hLong[14] - prevLo[14]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[14] = (hLat[14] + prevLa[14]) / 2 ; hLong[14] = (hLong[14] + prevLo[14]) / 2 }
        prevLa[14] = hLat[14]
        prevLo[14] = hLong[14]
        messageLabel.text = "\(hLat[14]) - \(hLong[14])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h15(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[15] = here.coordinate.latitude
        hLong[15] = here.coordinate.longitude
        if(abs(hLat[15] - prevLa[15]) < 6.0e-05 && abs(hLong[15] - prevLo[15]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[15] = (hLat[15] + prevLa[15]) / 2 ; hLong[15] = ((hLong[15] + prevLo[15])/2)}
        prevLa[15] = hLat[15]
        prevLo[15] = hLong[15]
        messageLabel.text = "\(hLat[15]) - \(hLong[15])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h16(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[16] = here.coordinate.latitude
        hLong[16] = here.coordinate.longitude
        if(abs(hLat[16] - prevLa[16]) < 6.0e-05 && abs(hLong[16] - prevLo[16]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[16] = (hLat[16] + prevLa[16]) / 2 ; hLong[16] = (hLong[16] + prevLo[16]) / 2 }
        prevLa[16] = hLat[16]
        prevLo[16] = hLong[16]
        messageLabel.text = "\(hLat[16]) - \(hLong[16])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h17(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[17] = here.coordinate.latitude
        hLong[17] = here.coordinate.longitude
        if(abs(hLat[17] - prevLa[17]) < 6.0e-05 && abs(hLong[17] - prevLo[17]) < (6.0e-05 / cos(90 * Double.pi / 180))){hLat[17] = (hLat[17] + prevLa[17]) / 2 ; hLong[17] = (hLong[17] + prevLo[17]) / 2 }
        prevLa[17] = hLat[17]
        prevLo[17] = hLong[17]
        messageLabel.text = "\(hLat[17]) - \(hLong[17])"
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func h18(_ sender: UIButton, forEvent event: UIEvent) {
        let here = locationManager.location!
        hLat[18] = here.coordinate.latitude
        hLong[18] = here.coordinate.longitude
        //print("BEFORE prev lat \(prevLa[18]) \tlat \(hLat[18]) \tdelta \(abs(prevLa[18] - hLat[18]))\t avg \((hLat[18] + prevLa[18]) / 2)\n")
        //print("BEFORE prev long \(prevLo[18]) \tlong \(hLong[18]) \tdelta \(abs(prevLo[18] - hLong[18]))\t avg \((hLong[18] + prevLo[18]) / 2)")
        
        if(abs(hLat[18] - prevLa[18]) < 6.0e-05 && abs(hLong[18] - prevLo[18]) < (6.0e-05 / cos(90 * Double.pi / 180)))
        {
            print("XXXXXXXXXX CHANGED XXXXXXXXX")
            hLat[18] = (hLat[18] + prevLa[18]) / 2
            hLong[18] = (hLong[18] + prevLo[18]) / 2
        }
        prevLa[18] = hLat[18]
        prevLo[18] = hLong[18]
        messageLabel.text = "\(hLat[18]) - \(hLong[18])"
        guard !courseName.text!.isEmpty else {return}
        calculateAllDistances()
        saveFullcourse()
    }
    
    @IBAction func clearCourse(_ sender: Any) {
        let ac = UIAlertController(title: "ENTER NEW COURSE", message:  "Enter the name and address then go in the center of each green and click on the hole number to memorize it.", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Start a new mapping", style: UIAlertAction.Style.destructive, handler: { action in
            // do something like...
            
            // clear all data
            self.courseName.text = String()
            self.courseDescr.text = String()
       
            for i in 1...18 {
                hLat[i] = 0.00001
                hLong[i] = 0.00001
            }
            
            self.calculateAllDistances()
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
    @IBAction func courseDelete(_ sender: Any) {
        
        let ac = UIAlertController(title: "DELETING COURSE", message:  "You are going do delete \(course), ALL DATA WILL BE LOST. Do you want to proceed?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
            // do something like...
            _ = CoreDataController.shared.deleteCourse(name: self.courseName.text!)
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)
    }
    

    func saveFullcourse() {
        
        // create the alert
        let ac = UIAlertController(title: "SAVING THIS GOLF COURSE", message: "You are saving \(courseName.text!). The previouse course, if any, will be overwritten. Do you want to proceed?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.destructive, handler: { [self] action in
            
            guard !courseName.text!.isEmpty else {return}
            
            _ = CoreDataController.shared.deleteCourse(name: courseName.text!)
            CoreDataController.shared.addCourse(name: courseName.text!,
                                                desc: courseName.text!,
                                                h01la: hLat[1],
                                                h01lo: hLong[1],
                                                h02la: hLat[2],
                                                h02lo: hLong[2],
                                                h03la: hLat[3],
                                                h03lo: hLong[3],
                                                h04la: hLat[4],
                                                h04lo: hLong[4],
                                                h05la: hLat[5],
                                                h05lo: hLong[5],
                                                h06la: hLat[6],
                                                h06lo: hLong[6],
                                                h07la: hLat[7],
                                                h07lo: hLong[7],
                                                h08la: hLat[8],
                                                h08lo: hLong[8],
                                                h09la: hLat[9],
                                                h09lo: hLong[9],
                                                h10la: hLat[10],
                                                h10lo: hLong[10],
                                                h11la: hLat[11],
                                                h11lo: hLong[11],
                                                h12la: hLat[12],
                                                h12lo: hLong[12],
                                                h13la: hLat[13],
                                                h13lo: hLong[13],
                                                h14la: hLat[14],
                                                h14lo: hLong[14],
                                                h15la: hLat[15],
                                                h15lo: hLong[15],
                                                h16la: hLat[16],
                                                h16lo: hLong[16],
                                                h17la: hLat[17],
                                                h17lo: hLong[17],
                                                h18la: hLat[18],
                                                h18lo: hLong[18])
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)
        
    }
    

    
    func userDistance(lat: Double, long: Double) -> Double? {
        
        guard let userLocation = locationManager.location else {
            return 0.0 // User location unknown!
        }
        
        let pointLocation = CLLocation(latitude: lat, longitude: long)
        var d = userLocation.distance(from: pointLocation)
        if (unitOfMeasure == "y") {
            d = d / 0.9144
        }
        
        return d
    }
    
    func calculateAllDistances(){
        if(hLat[1]>0.0001){h1d.setTitle("Hole 01 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[1], long: hLong[1])!)), for:UIControl.State.normal)} else { h1d.setTitle("Hole 01 - n/a", for:UIControl.State.normal)}
        if(hLat[2]>0.0001){h2d.setTitle("Hole 02 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[2], long: hLong[2])!)), for:UIControl.State.normal)} else { h2d.setTitle("Hole 02 - n/a", for:UIControl.State.normal)}
        if(hLat[3]>0.0001){h3d.setTitle("Hole 03 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[3], long: hLong[3])!)), for:UIControl.State.normal)} else { h3d.setTitle("Hole 03 - n/a", for:UIControl.State.normal)}
        if(hLat[4]>0.0001){h4d.setTitle("Hole 04 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[4], long: hLong[4])!)), for:UIControl.State.normal)} else { h4d.setTitle("Hole 04 - n/a", for:UIControl.State.normal)}
        if(hLat[5]>0.0001){h5d.setTitle("Hole 05 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[5], long: hLong[5])!)), for:UIControl.State.normal)} else { h5d.setTitle("Hole 05 - n/a", for:UIControl.State.normal)}
        if(hLat[6]>0.0001){h6d.setTitle("Hole 06 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[6], long: hLong[6])!)), for:UIControl.State.normal)} else { h6d.setTitle("Hole 06 - n/a", for:UIControl.State.normal)}
        if(hLat[7]>0.0001){h7d.setTitle("Hole 07 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[7], long: hLong[7])!)), for:UIControl.State.normal)} else { h7d.setTitle("Hole 07 - n/a", for:UIControl.State.normal)}
        if(hLat[8]>0.0001){h8d.setTitle("Hole 08 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[8], long: hLong[8])!)), for:UIControl.State.normal)} else { h8d.setTitle("Hole 08 - n/a", for:UIControl.State.normal)}
        if(hLat[9]>0.0001){h9d.setTitle("Hole 09 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[9], long: hLong[9])!)), for:UIControl.State.normal)} else { h9d.setTitle("Hole 09 - n/a", for:UIControl.State.normal)}
        if(hLat[10]>0.0001){h10d.setTitle("Hole 10 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[10], long: hLong[10])!)), for:UIControl.State.normal)} else { h10d.setTitle("Hole 10 - n/a", for:UIControl.State.normal)}
        if(hLat[11]>0.0001){h11d.setTitle("Hole 11 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[11], long: hLong[11])!)), for:UIControl.State.normal)} else { h11d.setTitle("Hole 11 - n/a", for:UIControl.State.normal)}
        if(hLat[12]>0.0001){h12d.setTitle("Hole 12 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[12], long: hLong[12])!)), for:UIControl.State.normal)} else { h12d.setTitle("Hole 12 - n/a", for:UIControl.State.normal)}
        if(hLat[13]>0.0001){h13d.setTitle("Hole 13 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[13], long: hLong[13])!)), for:UIControl.State.normal)} else { h13d.setTitle("Hole 13 - n/a", for:UIControl.State.normal)}
        if(hLat[14]>0.0001){h14d.setTitle("Hole 14 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[14], long: hLong[14])!)), for:UIControl.State.normal)} else { h14d.setTitle("Hole 14 - n/a", for:UIControl.State.normal)}
        if(hLat[15]>0.0001){h15d.setTitle("Hole 15 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[15], long: hLong[15])!)), for:UIControl.State.normal)} else { h15d.setTitle("Hole 15 - n/a", for:UIControl.State.normal)}
        if(hLat[16]>0.0001){h16d.setTitle("Hole 16 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[16], long: hLong[16])!)), for:UIControl.State.normal)} else { h16d.setTitle("Hole 16 - n/a", for:UIControl.State.normal)}
        if(hLat[17]>0.0001){h17d.setTitle("Hole 17 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[17], long: hLong[17])!)), for:UIControl.State.normal)} else { h17d.setTitle("Hole 17 - n/a", for:UIControl.State.normal)}
        if(hLat[18]>0.0001){h18d.setTitle("Hole 18 - \(unitOfMeasure) " + String(Int(userDistance(lat: hLat[18], long: hLong[18])!)), for:UIControl.State.normal)} else { h18d.setTitle("Hole 18 - n/a", for:UIControl.State.normal)}
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //before closing the app save the current setup
        CoreDataController.shared.saveSetup(
            uOm: unitOfMeasure,
            freeMap: freeMap,
            show3Holes: threeHoles,
            userName: userName,
            password: password)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //before closing the app save the current setup
        if CoreDataController.shared.countCourses() != 0 {
            // read all time because a new course could be chosen in the main view
            course = names[myRow]
            let x = CoreDataController.shared.loadCourseFromName(name: course)
            desc = x.desc!
            hLat[1] = Double(x.h01la)
            hLong[1] = Double(x.h01lo)
            hLat[2] = Double(x.h02la)
            hLong[2] = Double(x.h02lo)
            hLat[3] = Double(x.h03la)
            hLong[3] = Double(x.h03lo)
            hLat[4] = Double(x.h04la)
            hLong[4] = Double(x.h04lo)
            hLat[5] = Double(x.h05la)
            hLong[5] = Double(x.h05lo)
            hLat[6] = Double(x.h06la)
            hLong[6] = Double(x.h06lo)
            hLat[7] = Double(x.h07la)
            hLong[7] = Double(x.h07lo)
            hLat[8] = Double(x.h08la)
            hLong[8] = Double(x.h08lo)
            hLat[9] = Double(x.h09la)
            hLong[9] = Double(x.h09lo)
            hLat[10] = Double(x.h10la)
            hLong[10] = Double(x.h10lo)
            hLat[11] = Double(x.h11la)
            hLong[11] = Double(x.h11lo)
            hLat[12] = Double(x.h12la)
            hLong[12] = Double(x.h12lo)
            hLat[13] = Double(x.h13la)
            hLong[13] = Double(x.h13lo)
            hLat[14] = Double(x.h14la)
            hLong[14] = Double(x.h14lo)
            hLat[15] = Double(x.h15la)
            hLong[15] = Double(x.h15lo)
            hLat[16] = Double(x.h16la)
            hLong[16] = Double(x.h16lo)
            hLat[17] = Double(x.h17la)
            hLong[17] = Double(x.h17lo)
            hLat[18] = Double(x.h18la)
            hLong[18] = Double(x.h18lo)
            prevLa = hLat
            prevLo = hLong
            
            
            courseName.text = course
            courseDescr.text = desc
            // calculate all distances
            calculateAllDistances()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
  
    }
}




