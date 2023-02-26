//
//  SetupVC.swift
//  EasyGolfMap
//
//  Created by Andrea Pozzoni on 02/04/21.
//

import UIKit
import MapKit
import CoreLocation
import SwiftUI


class SetupVC: UIViewController {

 
    @IBOutlet weak var threeHolesSwitch: UISwitch!
    @IBOutlet weak var freeMapSwitch: UISwitch!
    @IBOutlet weak var uOmSwitch: UISwitch!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPasswordTxt: UITextField!
    

    @IBAction func newUserTUI(_ sender: Any) {
        if (passwordTxt.text != repeatPasswordTxt.text)
        {
            let ac = UIAlertController(title: "ERROR", message:  "Password mismatch, please renter them.", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            // show the alert
            self.present(ac, animated: true, completion: nil)
        }
        else
        {
            // check if present in firEbase, if not create  xxxxxxxxxxxxxxxxx
            let ac = UIAlertController(title: "SAVING NEW USER", message:  "Creating a new user, take note of your password, it cannot be recovered. Do you want to proceed?", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.destructive, handler: { [self] action in
                // do something like...
                self.view.endEditing(true)
                userName = userNameTxt.text!
                password = passwordTxt.text!
                CoreDataController.shared.saveSetup(uOm: unitOfMeasure, freeMap: freeMap, show3Holes: threeHoles, userName: userNameTxt.text!, password: passwordTxt.text!)
            }))
            // show the alert
            self.present(ac, animated: true, completion: nil)
            print("qui arrivo")
            self.view.endEditing(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if threeHolesSwitch.isOn { threeHoles = true } else { threeHoles = false}
        if uOmSwitch.isOn { unitOfMeasure = "m"} else {unitOfMeasure = "y" }
        
        if freeMapSwitch.isOn { freeMap = true } else {freeMap = false }
        
        CoreDataController.shared.saveSetup(
            uOm: unitOfMeasure,
            freeMap: freeMap,
            show3Holes: threeHoles,
            userName: userName,
            password: password)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if threeHoles {threeHolesSwitch.setOn(true, animated: true) } else {threeHolesSwitch.setOn(false, animated: true) }
        if unitOfMeasure == "m" {uOmSwitch.setOn(true, animated: true)} else {uOmSwitch.setOn(false, animated: true) }
        if freeMap {freeMapSwitch.setOn(true, animated: true) } else {freeMapSwitch.setOn(false, animated: true) }
        userNameTxt.text = userName
        passwordTxt.text = password
        repeatPasswordTxt.text = password

    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }


    // Functions for developing purposes only
    
    @IBAction func createDefaultRanges(_ sender: Any) {
        
        let ac = UIAlertController(title: "CRATE DEFAULT COURSES", message:  "This routine is for testing purposes only, it will be unavailable in the final version. CREATE DEFAULT COURSES?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in


        CoreDataController.shared.addCourse(name: "HOME TEST",
                                           desc: "Meda (MB) - Italy",
                                           h01la: 45.665,
                                           h01lo: 9.1618,
                                           h02la: 45.6627,
                                           h02lo: 9.1568,
                                           h03la: 45.6628,
                                           h03lo: 9.1605,
                                           h04la: 45.659623,
                                           h04lo: 9.161290,
                                           h05la: 45.657570,
                                           h05lo: 9.151548,
                                           h06la: 45.658232,
                                           h06lo: 9.164787,
                                           h07la: 0.0001,
                                           h07lo: 0.0001,
                                           h08la: 0.0001,
                                           h08lo: 0.0001,
                                           h09la: 0.0001,
                                           h09lo: 0.0001,
                                           h10la: 0.0001,
                                           h10lo: 0.0001,
                                           h11la: 0.0001,
                                           h11lo: 0.0001,
                                           h12la: 0.0001,
                                           h12lo: 0.0001,
                                           h13la: 0.0001,
                                           h13lo: 0.0001,
                                           h14la: 0.0001,
                                           h14lo: 0.0001,
                                           h15la: 0.0001,
                                           h15lo: 0.0001,
                                           h16la: 0.0001,
                                           h16lo: 0.0001,
                                           h17la: 0.0001,
                                           h17lo: 0.0001,
                                           h18la: 0.0001,
                                           h18lo: 0.0001)
        
        CoreDataController.shared.addCourse(name: "BRICCH GOLF",
                                           desc: "Via Segantini, 7 - Barlassina (MB) - Italy",
                                           h01la: 45.6485595703125,
                                           h01lo: 9.119774874122843,
                                           h02la: 45.648834228515625,
                                           h02lo: 9.12062310490628,
                                           h03la: 45.647674560546875,
                                           h03lo: 9.12105261199581,
                                           h04la: 0.0001,
                                           h04lo: 0.0001,
                                           h05la: 0.0001,
                                           h05lo: 0.0001,
                                           h06la: 0.0001,
                                           h06lo: 0.0001,
                                           h07la: 0.0001,
                                           h07lo: 0.0001,
                                           h08la: 0.0001,
                                           h08lo: 0.0001,
                                           h09la: 0.0001,
                                           h09lo: 0.0001,
                                           h10la: 0.0001,
                                           h10lo: 0.0001,
                                           h11la: 0.0001,
                                           h11lo: 0.0001,
                                           h12la: 0.0001,
                                           h12lo: 0.0001,
                                           h13la: 0.0001,
                                           h13lo: 0.0001,
                                           h14la: 0.0001,
                                           h14lo: 0.0001,
                                           h15la: 0.0001,
                                           h15lo: 0.0001,
                                           h16la: 0.0001,
                                           h16lo: 0.0001,
                                           h17la: 0.0001,
                                           h17lo: 0.0001,
                                           h18la: 45.647125244140625,
                                           h18lo: 9.120832625146313)
        
        CoreDataController.shared.addCourse(name: "BARLASSINA GOLF",
                                           desc: "Via Privata Golf, 49 - LENTATE s/S (MB) - Italy",
                                           h01la: 45.657257,
                                           h01lo: 9.113961,
                                           h02la: 45.655612,
                                           h02lo: 9.115940,
                                           h03la: 45.656990,
                                           h03lo: 9.120306,
                                           h04la: 45.655618,
                                           h04lo: 9.116609,
                                           h05la: 45.654921,
                                           h05lo: 9.112751,
                                           h06la: 45.655763,
                                           h06lo: 9.108913,
                                           h07la: 45.657940,
                                           h07lo: 9.113539,
                                           h08la: 45.658343,
                                           h08lo: 9.116986,
                                           h09la: 45.658641,
                                           h09lo: 9.118864,
                                           h10la: 45.658902,
                                           h10lo: 9.113299,
                                           h11la: 45.655943,
                                           h11lo: 9.107572,
                                           h12la: 45.656652,
                                           h12lo: 9.106853,
                                           h13la: 45.658448,
                                           h13lo: 9.112312,
                                           h14la: 45.661893,
                                           h14lo: 9.111359,
                                           h15la: 45.663107,
                                           h15lo: 9.110293,
                                           h16la: 45.660330,
                                           h16lo: 9.114535,
                                           h17la: 45.661292,
                                           h17lo: 9.114292,
                                           h18la: 45.659551,
                                           h18lo: 9.117971)
        
        CoreDataController.shared.addCourse(name: "CARIMATE GOLF",
                                           desc: "Via per Montesolaro - CARIMATE (CO) - Italy",
                                           h01la: 45.70715239294434,
                                           h01lo: 9.109338358112575,
                                           h02la: 45.707308,
                                           h02lo: 9.108045,
                                           h03la: 45.71185302734375,
                                           h03lo: 9.107588083938658,
                                           h04la: 45.71455843945313,
                                           h04lo: 9.10837291331392,
                                           h05la: 45.711325,
                                           h05lo: 9.104531,
                                           h06la: 45.709969,
                                           h06lo: 9.102844,
                                           h07la: 45.7085,
                                           h07lo: 9.105769,
                                           h08la: 45.706007,
                                           h08lo: 9.111137,
                                           h09la: 45.706526484375004,
                                           h09lo: 9.113990090642282,
                                           h10la: 45.707956,
                                           h10lo: 9.117057,
                                           h11la: 45.712161,
                                           h11lo: 9.118970,
                                           h12la: 45.710334,
                                           h12lo: 9.115617,
                                           h13la: 45.711431,
                                           h13lo: 9.118228,
                                           h14la: 45.708737,
                                           h14lo: 9.115110,
                                           h15la: 45.709713,
                                           h15lo: 9.117407,
                                           h16la: 45.707013,
                                           h16lo: 9.115865,
                                           h17la: 45.708551,
                                           h17lo: 9.114524,
                                           h18la: 45.705523,
                                           h18lo: 9.115323)
        
        CoreDataController.shared.addCourse(name: "PONTE DI LEGNO GOLF",
                                           desc: "Località Valbione",
                                           h01la : 46.2431640625,
                                           h01lo : 10.5069644198563,
                                           h02la : 46.2403576013183,
                                           h02lo : 10.5092972717181,
                                           h03la : 46.2396354675293,
                                           h03lo : 10.510733366939,
                                           h04la : 46.2408099067382,
                                           h04lo : 10.5097417814095,
                                           h05la : 46.242049331543,
                                           h05lo : 10.5090360328603,
                                           h06la : 46.2444458007812,
                                           h06lo : 10.5087083792556,
                                           h07la : 46.2469100952148,
                                           h07lo : 10.5086962627977,
                                           h08la : 46.2423038482666,
                                           h08lo : 10.5086431722427,
                                           h09la : 46.2462997436523,
                                           h09lo : 10.5070453807643,
                                           h10la : 46.2431640625,
                                           h10lo : 10.5069644198563,
                                           h11la : 46.2403576013183,
                                           h11lo : 10.5092972717181,
                                           h12la : 46.2396354675293,
                                           h12lo : 10.510733366939,
                                           h13la : 46.2408099067382,
                                           h13lo : 10.5097417814095,
                                           h14la : 46.242049331543,
                                           h14lo : 10.5090360328603,
                                           h15la : 46.2444458007812,
                                           h15lo : 10.5087083792556,
                                           h16la : 46.2469100952148,
                                           h16lo : 10.5086962627977,
                                           h17la : 46.2423038482666,
                                           h17lo : 10.5086431722427,
                                           h18la : 46.2462997436523,
                                           h18lo : 10.5070453807643)
        
        CoreDataController.shared.addCourse(name: "AUGUSTA National Golf",
                                           desc: "2604 Washington Rd, Augusta - GA 30904 - USA",
                                           h01la: 33.504473,
                                           h01lo: -82.023507,
                                           h02la: 33.500356,
                                           h02lo: -82.023514,
                                           h03la: 33.501699,
                                           h03lo: -82.026006,
                                           h04la: 33.501861,
                                           h04lo: -82.027985,
                                           h05la: 33.498340,
                                           h05lo: -82.027434,
                                           h06la: 33.500325,
                                           h06lo: -82.026845,
                                           h07la: 33.499504,
                                           h07lo: -82.023339,
                                           h08la: 33.503727,
                                           h08lo: -82.023722,
                                           h09la: 33.502295,
                                           h09lo: -82.020639,
                                           h10la: 33.498058,
                                           h10lo: -82.020438,
                                           h11la: 33.495186,
                                           h11lo: -82.022184,
                                           h12la: 33.493650,
                                           h12lo: -82.023462,
                                           h13la: 33.497094,
                                           h13lo: -82.025564,
                                           h14la: 33.497437,
                                           h14lo: -82.021368,
                                           h15la: 33.498897,
                                           h15lo: -82.025594,
                                           h16la: 33.499598,
                                           h16lo: -82.026492,
                                           h17la: 33.498782,
                                           h17lo: -82.022175,
                                           h18la: 33.501889,
                                           h18lo: -82.020512)
            
            CoreDataController.shared.addCourse(name: "CITY RUN",
                                               desc: "Cupertino - USA",
                                               h01la: 37.33063,
                                               h01lo: -122.0303,
                                               h02la: 37.3305,
                                               h02lo: -122.03056,
                                               h03la: 37.3309,
                                               h03lo: -122.0321,
                                               h04la: 37.331,
                                               h04lo: -122.03022,
                                               h05la: 37.3302,
                                               h05lo: -122.0303,
                                               h06la: 37.3307,
                                               h06lo: -122.03026,
                                               h07la: 37.325,
                                               h07lo: -122.0307,
                                               h08la: 0.0001,
                                               h08lo: 0.0001,
                                               h09la: 0.0001,
                                               h09lo: 0.0001,
                                               h10la: 0.0001,
                                               h10lo: 0.0001,
                                               h11la: 0.0001,
                                               h11lo: 0.0001,
                                               h12la: 0.0001,
                                               h12lo: 0.0001,
                                               h13la: 0.0001,
                                               h13lo: 0.0001,
                                               h14la: 0.0001,
                                               h14lo: 0.0001,
                                               h15la: 0.0001,
                                               h15lo: 0.0001,
                                               h16la: 0.0001,
                                               h16lo: 0.0001,
                                               h17la: 0.0001,
                                               h17lo: 0.0001,
                                               h18la: 0.0001,
                                               h18lo: 0.0001)
        
            CoreDataController.shared.addCourse(name: "CAMUZZAGO",
                                               desc: "GOLF ANTICO BORGO DI CAMUZZAGO",
                                                h01la: 45.60887095,
                                                h01lo: 9.4429593,
                                                h02la: 45.608367919921875,
                                                h02lo: 9.43093709969294,
                                                h03la: 45.610687255859375,
                                                h03lo: 9.430431459413267,
                                                h04la: 45.611784,
                                                h04lo: 9.426465,
                                                h05la: 45.611053466796875,
                                                h05lo: 9.430196735915175,
                                                h06la: 45.610801,
                                                h06lo: 9.428002,
                                                h07la: 45.60919761657715,
                                                h07lo: 9.43132976388867,
                                                h08la: 45.609078,
                                                h08lo: 9.429697,
                                                h09la: 45.60900688171387,
                                                h09lo: 9.427802462311782,
                                                h10la: 0.0001,
                                                h10lo: 0.0001,
                                                h11la: 0.0001,
                                                h11lo: 0.0001,
                                                h12la: 0.0001,
                                                h12lo: 0.0001,
                                                h13la: 0.0001,
                                                h13lo: 0.0001,
                                                h14la: 0.0001,
                                                h14lo: 0.0001,
                                                h15la: 0.0001,
                                                h15lo: 0.0001,
                                                h16la: 0.0001,
                                                h16lo: 0.0001,
                                                h17la: 0.0001,
                                                h17lo: 0.0001,
                                                h18la: 0.0001,
                                                h18lo: 0.0001)
            

        print("added default Ranges")
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
    @IBAction func listRanges(_ sender: UIButton) {
        let ac = UIAlertController(title: "LIST CONTENT", message:  "This routine is for testing purposes only, it will be unavailable in the final version. Listing appears in the console, not on the iPhone.", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
        
        print("LISTING THE RANGES IN MEMORY")
        print("--------------------------------------------------")
        let allRanges = CoreDataController.shared.loadAllCourses()
        for x in allRanges {
            print("Name \(x.name!) - 01 La/Lo \t\(x.h01la) \t\(x.h01lo) ")
            print("Name \(x.name!) - 02 La/Lo \t\(x.h02la) \t\(x.h02lo) ")
            print("Name \(x.name!) - 03 La/Lo \t\(x.h03la) \t\(x.h03lo) ")
            print("Name \(x.name!) - 04 La/Lo \t\(x.h04la) \t\(x.h04lo) ")
            print("Name \(x.name!) - 05 La/Lo \t\(x.h05la) \t\(x.h05lo) ")
            print("Name \(x.name!) - 06 La/Lo \t\(x.h06la) \t\(x.h06lo) ")
            print("Name \(x.name!) - 07 La/Lo \t\(x.h07la) \t\(x.h07lo) ")
            print("Name \(x.name!) - 08 La/Lo \t\(x.h08la) \t\(x.h08lo) ")
            print("Name \(x.name!) - 09 La/Lo \t\(x.h09la) \t\(x.h09lo) ")
            print("Name \(x.name!) - 10 La/Lo \t\(x.h10la) \t\(x.h10lo) ")
            print("Name \(x.name!) - 11 La/Lo \t\(x.h11la) \t\(x.h11lo) ")
            print("Name \(x.name!) - 12 La/Lo \t\(x.h12la) \t\(x.h12lo) ")
            print("Name \(x.name!) - 13 La/Lo \t\(x.h13la) \t\(x.h13lo) ")
            print("Name \(x.name!) - 14 La/Lo \t\(x.h14la) \t\(x.h14lo) ")
            print("Name \(x.name!) - 15 La/Lo \t\(x.h15la) \t\(x.h15lo) ")
            print("Name \(x.name!) - 16 La/Lo \t\(x.h16la) \t\(x.h16lo) ")
            print("Name \(x.name!) - 17 La/Lo \t\(x.h17la) \t\(x.h17lo) ")
            print("Name \(x.name!) - 18 La/Lo \t\(x.h18la) \t\(x.h18lo) ")
        }
        let setup = CoreDataController.shared.loadSetup()
        for x in setup {
            print("UOM \(x.yardsOrMeters!)\t 3h - \(x.showThreeHoles) \t freeMap - \(x.freeMap)     user \(userName) - passw \(password)")
        }
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)

            
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        // for testing purposes only
        
        let ac = UIAlertController(title: "ERASE ALL DATA", message:  "This routine is for testing purposes only, it will be unavailable in the final version. DELETE ALL?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        ac.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { action in
            CoreDataController.shared.deleteAll()
            CoreDataController.shared.deleteSetup()
        }))
        // show the alert
        self.present(ac, animated: true, completion: nil)

        //errMess.text = "all deleted"
    }

}
