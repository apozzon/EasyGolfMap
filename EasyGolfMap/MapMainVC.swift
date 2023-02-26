//
// MapScreen.swift
// EasyGolfMap
//
//  Created by Andrea Pozzoni on 25/03/2021.
//
// improvements needed
// use cloud kit
// watch always connected or awake iphone if the app is not in background


import UIKit
import MapKit
import CoreLocation
import SwiftUI
import WatchConnectivity


// global variables, this shorten the code avoiding to pass them through the functions

var regionInMeters: Double = 200    // size of the map around the the player or camera height
let pitchMap: CGFloat = 85          // angle of the map camera (90 is the horizon, 0 is nadir)
var bearing = 0.0                   // initiallly the map is bearing north
var cameraDistance: Double = 1500   // distance of the camera from userPosition (higher = bigger map vision)
var myRow = 0                       // pointer of the chosen driving course
var emptyCoreData = true            // if no data in the system, initializatopn of Mapcourse may fail
var course = String()                // name of the course in use
var desc = String()                 // address of the above course
var stepperValue = "1"              // hole chosen by the user
var unitOfMeasure = "m"             // yards or meters
var threeHoles = false              // show two additional distances to hole on the map (false only the main one)
var freeMap = false                 // free map you can move it as you wish, false you the app wioll bear to the choses hole
var userName = String()             // to be used with external resources
var password = String()             // as above

// variables for TABLEVIEW to contain the name of the fileds memorized locally, they should come from the databse reading, next version
var names = [String]()              // contains the names of the golf courses in memory
var hLat = [Double]()               // contains the latitudes of the hole centers [0] is the club house
var hLong = [Double]()              // contains the longitude of the hole centers as above
// var teelat = [Double]()           // tee area latitude - for future
// var teelong = [Double]()          // tee area longitude - for future
// var p1lat = [Double]()           // penalty area 1 latitude - for future
// var p1long = [Double]()          // penalty area 1 longitude - for future
// var p2lat = [Double]()           // penalty area 2 latitude - for future
// var p2long = [Double]()          // penalty area 2 longitude - for futur

//  ***********************CLASS MAP SCREEN ****************************
class MapMainVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // distancies of all holed of the course. The user can decisde to show 3 at a time, this is good in small courses in driving ranges where you want (not really suggested) to shot from anywhere to different greens.
    var distance = [Int]()
    var n1 = Int()                   // next hole chosen (required if 3 hole option is activated
    var n2 = Int()                   // next two hole chosen (required if 3 hole option is activated

    // handling the connection with the watch
    var connectivityHandler = WatchSessionManager.shared
    
    let locationManager = CLLocationManager()       // the location manager used

    

    // IBO for buttons and labels
    @IBOutlet weak var mapView: MKMapView!          // the main map
    @IBOutlet weak var tableView: UITableView!      // the table containing the names of the memorized golf courses
    @IBOutlet weak var lblName: UILabel!            // the name of the displayed course
    @IBOutlet weak var slider: UISlider!            // zooms the map
    @IBOutlet weak var distanceToHole1: UILabel!    // shows the distance to the chosen hole
    @IBOutlet weak var distanceToHole2: UILabel!    // same as above
    @IBOutlet weak var distanceToHole3: UILabel!    // same as above
    @IBOutlet weak var stepperOutlet: UIStepper!    // moves though the holes
    
    // increasing the size of the stepper
    func stepperEnlarge() {
        stepperOutlet.transform = stepperOutlet.transform.scaledBy(x: 1.5, y: 1.5)
    }
    
    // Moving through the holes. The stepper value represents the chosen hole number, n1 is the next hole number and n2 the second next.
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        stepperValue = (Int(stepperOutlet.value).description)
        n1 = Int(stepperOutlet.value) + 1
        n2 = Int(stepperOutlet.value) + 2
        if  Int(stepperOutlet.value) == 17 {
            n1 = 18
            n2 = 1
        }
        if  Int(stepperOutlet.value) == 18 {
            n1 = 1
            n2 = 2
        }
        
        updateDistanceLabel()  // updates the distance shown on the device
    }
    
    // zoom changing the distance of the camera from the user position
    @IBAction func sliderMoved(_ sender: UISlider, forEvent event: UIEvent) {
        cameraDistance=Double(slider.value)
        
    }
    
    // center the map on the user position
    @IBAction func centerTheMap(_ sender: Any) {
        centerViewOnUserLocation()
    }
    
    //read all the names of the stored courses rebuilding all arrays where the data are stored. Re-read is required when you jump back from mapping a new course so you can see it.
    @IBAction func showTable(_ sender: Any) {
        names.removeAll()      // first erase the array of names to load in the table
        lblName.text = ""       // cancel the local course name
        readAllCourses()           // recreate the names[]
        tableView.reloadData()  // the table is reloaded with the new names[]
        placeLocators()         // replace the locators on the mapview
        tableView.isHidden = false
    }
    
    // depending on the chosen hole numebr, the distances of the current and next two is calculated and shown on screen.
    func updateDistanceLabel(){
        guard locationManager.location != nil else { return }
        // update all distances
        //allDistances()
        
        for i in 1...18 {
            if stepperOutlet.value == 0 {stepperOutlet.value = 1}
            if(stepperValue == String(i)) {
                
                n1 = Int(stepperOutlet.value) + 1
                n2 = Int(stepperOutlet.value) + 2
                if  Int(stepperOutlet.value) == 17 {
                    n1 = 18
                    n2 = 1
                }
                if  Int(stepperOutlet.value) == 18 {
                    n1 = 1
                    n2 = 2
                }
                bearing = getBearingBetweenTwoPoints(point1: locationManager.location!, point2: CLLocation(latitude: hLat[i], longitude: hLong[i]))
                var dst1 = Int(userDistance(lat: hLat[i], long: hLong[i])!)
                if dst1 > 9999 {dst1 = 9999}
                var dst2 = Int(userDistance(lat: hLat[n1], long: hLong[n1])!)
                if dst2 > 9999 {dst2 = 9999}
                var dst3 = Int(userDistance(lat: hLat[n2], long: hLong[n2])!)
                if dst3 > 9999 {dst3 = 9999}
                distanceToHole1.text = "Hole \(stepperValue)  \(unitOfMeasure) ->  \(dst1)"
                distanceToHole2.text = "Hole \(n1)  \(unitOfMeasure) ->  \(dst2)"
                distanceToHole3.text = "Hole \(n2)  \(unitOfMeasure) ->  \(dst3)"
                cameraDistance = Double(dst1 * 5)
                regionInMeters = Double(dst1) * 1.5
                print("hole chosen \(stepperValue) cameraDistance \(cameraDistance)  regionInMeters \(regionInMeters)")
                centerViewOnUserLocation()
            }
            
        }
        
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
            /*      this is to move the center but it works only for latidude, neead to add bearing of map
            let centerPointOfregion = oldRegion.center
            let centerPointOfNewRegion = CLLocationCoordinate2DMake(centerPointOfregion.latitude + region.span.latitudeDelta/2.0, centerPointOfregion.longitude)
            let newRegion = MKCoordinateRegion(center: centerPointOfNewRegion, span: region.span)
            mapView.setRegion(newRegion, animated: true)
             */
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }

    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            let ac = UIAlertController(title: "YOUR LOCATION", message:  "Your exact position is required for this app to work. Please authorize in your privacy/location settings.", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Stop using the app.", style: UIAlertAction.Style.destructive, handler: { action in
                exit(-1)
            }))
            self.present(ac, animated: true, completion: nil)
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            let ac = UIAlertController(title: "YOUR LOCATION", message:  "Your exact position is required for this app to work.", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Proceed", style: UIAlertAction.Style.cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Stop using the app.", style: UIAlertAction.Style.destructive, handler: { action in
                exit(-1)
            }))
            
            self.present(ac, animated: true, completion: nil)
            locationManager.requestWhenInUseAuthorization()
            break
        default :
            break
        }
    }
    
    
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            let ac = UIAlertController(title: "YOUR LOCATION", message:  "Your exact position is required for this app to work.", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Proceed", style: UIAlertAction.Style.cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Stop using the app.", style: UIAlertAction.Style.destructive, handler: { action in
                exit(-1)
            }))
            self.present(ac, animated: true, completion: nil)
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            let ac = UIAlertController(title: "YOUR LOCATION", message:  "Your exact position is required for this app to work.", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Proceed", style: UIAlertAction.Style.cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Stop using the app.", style: UIAlertAction.Style.destructive, handler: { action in
                exit(-1)
            }))
            
            self.present(ac, animated: true, completion: nil)
            locationManager.requestWhenInUseAuthorization()
            break
        default :
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locationManager.location else { return }  //was locations.last
        //allDistances()
        updateDistanceLabel()
        mapView.camera.heading = bearing
        
        if !freeMap {
            let camera = MKMapCamera()
            camera.centerCoordinate = location.coordinate
            camera.pitch = pitchMap
            //camera.altitude = regionInMeters
            camera.heading = bearing
            camera.centerCoordinateDistance = cameraDistance
            mapView.setCamera(camera, animated: true)
        }
        
    }

    //returns the distance between the user position and a point defined as annotation
    func userDistanceFromPoint(from point: MKPointAnnotation) -> Double? {
        
        guard let userLocation = locationManager.location else {
            return nil // User location unknown!
        }
        let pointLocation = CLLocation(
            latitude:  point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
        return userLocation.distance(from: pointLocation)
    }
    
    
    //returns the distance between the user position and a point defined by latitude and longitude))
    func userDistance(lat: Double, long: Double) -> Double? {
        guard let userLocation = locationManager.location else {
            return 0.0// User location unknown!
        }
        let pointLocation = CLLocation(latitude: lat, longitude: long)
        var d = userLocation.distance(from: pointLocation)
        if (unitOfMeasure == "y") {
            d = d / 0.9144
        }
        
        return d
    }
    
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    func getBearingBetweenTwoPoints(point1 : CLLocation, point2 : CLLocation) -> Double {
        guard locationManager.location != nil else { return 0.0}
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        let y = sin(lon2 - lon1) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
    }

    
    // place the locators on the map
    func placeLocators(){
        
        mapView.removeAnnotations(mapView.annotations)
        for i in 1...18{
            let hole = MKPointAnnotation()
            hole.coordinate = CLLocationCoordinate2D(latitude: hLat[i] , longitude: hLong[i])
            hole.title = String(i)
            hole.subtitle = String(i)
            mapView.addAnnotation(hole)
            
        }
    }

    
    // *********************** FUNCTIONS FOR TABLEVIEW *****************************
    // Youtube How to Create TableView in Xcode 12 (Swift 5)
    
    // names is coming from the reding of the core base in the didLoad
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myRow = indexPath.row
        course = names[myRow]
        readMapDataOfEligedCourse()
        tableView.isHidden = true
        lblName.text = course
        placeLocators()
        stepperOutlet.value = 1
        //updateDistanceLabel()
        readMapDataOfEligedCourse()
        bearing = getBearingBetweenTwoPoints(point1: locationManager.location!, point2: CLLocation(latitude: hLat[1], longitude: hLong[1]))
        distanceToHole1.text = "Hole 1  \(unitOfMeasure) ->  \(Int(userDistance(lat: hLat[1], long: hLong[1])!))"
        distanceToHole2.text = "Hole 2  \(unitOfMeasure) ->  \(Int(userDistance(lat: hLat[2], long: hLong[2])!))"
        distanceToHole3.text = "Hole 3  \(unitOfMeasure) ->  \(Int(userDistance(lat: hLat[3], long: hLong[3])!))"
        
        
    }
    // number of records
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) ->Int {
        return names.count
    }
    
    // stuffing the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
        
    }
    
    func readAllCourses(){
        if CoreDataController.shared.countCourses() != 0 {
            let allCourses = CoreDataController.shared.loadAllCourses()
            var courseLocationDistance = 99999999.9
            for x in allCourses {
                names.append(x.name!)
                let x = CoreDataController.shared.loadCourseFromName(name: x.name!)
                hLat[1] = Double(x.h01la)
                hLong[1] = Double(x.h01lo)
                print("\(x.name!) --- current distance ---> \(userDistance(lat: x.h01la , long: x.h01lo)!)")
                // save the data of the closest course
                if (userDistance(lat: hLat[1] , long: hLong[1])! < courseLocationDistance){
                    courseLocationDistance = userDistance(lat: hLat[1] , long: hLong[1])!
                    lblName.text = x.name!
                    course = x.name!
                    desc = x.desc!
                }
                
            }
            
            print("the closest is ---> \(course)")
            
            readMapDataOfEligedCourse()
            //Reading the data of the closest course
            let x = CoreDataController.shared.loadCourseFromName(name: course)
            desc = x.desc!
            
            // sort the names table
            names.sort()
            // find the pointer number of the closest golf
            for i in 0...names.count-1 {
                if names[i] == course {myRow = i}
                
                
            }
            // place the locators on the map
            placeLocators()
        }
        
    }
    
    func readMapDataOfEligedCourse(){
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
        
    }
    
    // inizialization of variable arrays, required to avoid nil when the system is used the first time and to write down a lot of guard
    func initVars() {
        var i = 0
        while i < 19 {
            distance.append (0)
            hLat.append (0.00001)
            hLong.append (0.00001)
            i += 1
        }
    }
    
    // mandatory methods for connection with the watch that might be used later (stubs)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    // initializing the app
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let longPressGestRecon = UILongPressGestureRecognizer(target: self, action: #selector (longPress(press:)))
        longPressGestRecon.minimumPressDuration = 0.7
        mapView.addGestureRecognizer(longPressGestRecon)
        
        initVars()
        connectivityHandler.iOSDelegate = self
        stepperEnlarge()

        locationManagerDidChangeAuthorization(locationManager)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        mapView.delegate = self
        mapView.mapType = MKMapType.satellite
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        
        
        //checkLocationServices()//as soon as started check that the service is available and make the first map and user location
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        slider.setValue(Float(cameraDistance), animated: true)
        
        readAllCourses()
        
        
        // read setup data if existing
        if CoreDataController.shared.setupExist() != 0 {
            let setup = CoreDataController.shared.loadSetup()
            for x in setup {
                unitOfMeasure = x.yardsOrMeters!
                freeMap = x.freeMap
                threeHoles = x.showThreeHoles
                if x.userName != nil {
                    userName = x.userName!
                    password = x.password!
                }
            }
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        locationManager.pausesLocationUpdatesAutomatically = false
        //before closing the app save the current setup
        CoreDataController.shared.saveSetup(
            uOm: unitOfMeasure,
            freeMap: freeMap,
            show3Holes: threeHoles,
            userName: userName,
            password: password)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        // after setup, things may have changed so the page has to be updated
        centerViewOnUserLocation()
        updateDistanceLabel()
        stepperValue = (Int(stepperOutlet.value).description)
        n1 = Int(stepperOutlet.value) + 1
        n2 = Int(stepperOutlet.value) + 2
        if  Int(stepperOutlet.value) == 17 {
            n1 = 18
            n2 = 1
        }
        if  Int(stepperOutlet.value) == 18 {
            n1 = 1
            n2 = 2
        }
        
        if threeHoles {
            distanceToHole1.isHidden = false
            distanceToHole2.isHidden = false
            distanceToHole3.isHidden = false
        } else {
            distanceToHole2.isHidden = true
            distanceToHole3.isHidden = true
            
        }
        
        if freeMap {slider.isHidden = true} else {slider.isHidden = false}
        
        let setup = CoreDataController.shared.loadSetup()
        for x in setup {
            unitOfMeasure = x.yardsOrMeters!
            freeMap = x.freeMap
            threeHoles = x.showThreeHoles
            if x.userName != nil {
                userName = x.userName!
                password = x.password!
            }
        }
        tableView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MapMainVC: iOSDelegate {
    // handling communication. The watch requests the distance from a specific hole and the phone replies to that specific hole.
    // Asynchronous communication, replies may be delayed. Tested iphone11 and watch 6 it takes less than half a second.
    
    func messageReceived(tuple: MessageReceived) {
        // Handle receiving message
        
        guard let reply = tuple.replyHandler else {
            return
        }
        
        // Need reply to counterpart. It could be done with a single generic call (not hole dependent) but, given the delay of the replies, it's better to double check the hole number on the watch.
        switch tuple.message["request"] as! RequestType.RawValue {
        case RequestType.hole0.rawValue : reply(["0" : "ready"])
        case RequestType.hole1.rawValue : let dst = String(Int(userDistance(lat: hLat[1], long: hLong[1])!)) ; stepperValue="1" ;reply(["1" : dst]) ; break
        case RequestType.hole2.rawValue : let dst = String(Int(userDistance(lat: hLat[2], long: hLong[2])!)) ;  stepperValue="2" ;reply(["2" : dst]) ; break
        case RequestType.hole3.rawValue : let dst = String(Int(userDistance(lat: hLat[3], long: hLong[3])!)) ;  stepperValue="3" ;reply(["3" : dst]) ; break
        case RequestType.hole4.rawValue : let dst = String(Int(userDistance(lat: hLat[4], long: hLong[4])!)) ;  stepperValue="4" ;reply(["4" : dst]) ; break
        case RequestType.hole5.rawValue : let dst = String(Int(userDistance(lat: hLat[5], long: hLong[5])!)) ; stepperValue="5" ; reply(["5" : dst]) ; break
        case RequestType.hole6.rawValue : let dst = String(Int(userDistance(lat: hLat[6], long: hLong[6])!)) ; stepperValue="6" ; reply(["6" : dst]) ; break
        case RequestType.hole7.rawValue : let dst = String(Int(userDistance(lat: hLat[7], long: hLong[7])!)) ; stepperValue="7" ; reply(["7" : dst]) ; break
        case RequestType.hole8.rawValue : let dst = String(Int(userDistance(lat: hLat[8], long: hLong[8])!)) ; stepperValue="8" ; reply(["8" : dst]) ; break
        case RequestType.hole9.rawValue : let dst = String(Int(userDistance(lat: hLat[9], long: hLong[9])!)) ; stepperValue="9" ; reply(["9" : dst]) ; break
        case RequestType.hole10.rawValue : let dst = String(Int(userDistance(lat: hLat[10], long: hLong[10])!)) ; stepperValue="10" ; reply(["10" : dst]) ; break
        case RequestType.hole11.rawValue : let dst = String(Int(userDistance(lat: hLat[11], long: hLong[11])!)) ; stepperValue="11" ; reply(["11" : dst]) ; break
        case RequestType.hole12.rawValue : let dst = String(Int(userDistance(lat: hLat[12], long: hLong[12])!)) ; stepperValue="12" ; reply(["12" : dst]) ; break
        case RequestType.hole13.rawValue : let dst = String(Int(userDistance(lat: hLat[13], long: hLong[13])!)) ; stepperValue="13" ; reply(["13" : dst]) ; break
        case RequestType.hole14.rawValue : let dst = String(Int(userDistance(lat: hLat[14], long: hLong[14])!)) ; stepperValue="14" ; reply(["14" : dst]) ; break
        case RequestType.hole15.rawValue : let dst = String(Int(userDistance(lat: hLat[15], long: hLong[15])!)) ; stepperValue="15" ; reply(["15" : dst]) ; break
        case RequestType.hole16.rawValue : let dst = String(Int(userDistance(lat: hLat[16], long: hLong[16])!)) ; stepperValue="16" ; reply(["16" : dst]) ; break
        case RequestType.hole17.rawValue : let dst = String(Int(userDistance(lat: hLat[17], long: hLong[17])!)) ; stepperValue="17" ; reply(["17" : dst]) ; break
        case RequestType.hole18.rawValue : let dst = String(Int(userDistance(lat: hLat[18], long: hLong[18])!)) ; stepperValue="18" ; reply(["18" : dst]) ; break
        default:
            reply(["error" : "error"])
            break
        }
    }
    
}

extension MapMainVC: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
            annotationView?.image = UIImage(named: "golfer_start.png")  // "golfer_end.png"
        }
        
        for i in 1...18 {
            if let title = annotation.subtitle, title == String(i) {
                annotationView?.image = UIImage(named: String(i) + ".png")
            }
        }
        
        mapView.showsUserLocation = true
        
        annotationView?.canShowCallout = false
        
        return annotationView
    }
    
    
    
    // tap the pin to get the distance and turning the map to bear to it
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let dist = userDistance(lat: view.annotation!.coordinate.latitude, long: view.annotation!.coordinate.longitude)!
        bearing = getBearingBetweenTwoPoints(point1: locationManager.location!, point2: CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude))
        print(bearing)
        // if the user clicks the userLocation pin (the red golfer) distance is zero and don't show any callout
        if dist > 0 {
            // the annotation in variable a contains Optional("xx"), this is just to remove it
            let a = String(describing: view.annotation?.subtitle!)
            var hole = String()
            for i in 1...18 {
                if a.contains(String(i)) {hole = String(i)}
            }
            
            let title = "Hole number " + hole
            
            let message = "distance " + String(Int(dist))
            // change the stepperValue to rotate to the hole if freeMap is off
            stepperOutlet.value = Double(hole)!
            stepperValue = hole
            cameraDistance = Double(dist * 5)
            regionInMeters = Double(dist) * 1.5
            updateDistanceLabel()
            centerViewOnUserLocation()
            
            let ac = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            // show the alert
           // self.present(ac, animated: true, completion: nil)
        }
    }
    
    // tapping on map you get coordinates of the point and show the distance
    @objc func longPress(press: UILongPressGestureRecognizer) {
        // Let's put in a log statement to see the order of events
        //print(#function)
        if press.state == .began {
            print ("pressed")
            
            let touchPoint = press.location(in: self.mapView)
            let location = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            //print ("\(location.latitude), \(location.longitude)")
            
            let dist = userDistance(lat: location.latitude, long: location.longitude)!
            // if the user clicks the userLocation pin (the red golfer) distance is zero and don't show any callout
            if dist > 0 {
                let title = "Distance to point tapped"
                let message =  String(Int(dist))
                let ac = UIAlertController(title: title, message:  message, preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                // show the alert
                self.present(ac, animated: true, completion: nil)
            }
        }
        
    }
    
    
}
