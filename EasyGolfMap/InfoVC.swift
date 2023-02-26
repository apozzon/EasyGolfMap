//
//  Info.swift
//  EasyGolfMap
//
//  Created by Andrea Pozzoni on 02/04/21.
//

import UIKit


var pages = [String]()

class InfoVC: UIViewController {
    // all hgis shit only becase I'm not able to make scroll working!
    @IBOutlet weak var lbl: UILabel!

    var x = 0
    
    let page0 = "QUICK INSTRUCTION FOR USE\n\nImportant: the player location is updated every 1-2 second depending on the speed of the device. During calculations the hole number may not change when tapping on the [-/+] button, if it is the case just tap it again.\n\nThe app is composed by 4 main screens activable in the bottombar.\nMAIN: shows the satellite map, your location, the pin locations, the distance to the hole you are looking at etc.\nMAP COURSE allow you to enter a new course or edit a pin location.\nSETUP is where you can setup your devic e chosing among some options.\nInstructions is what you are reading now!\n\nWhen started, the location is set to the closest golf course in memory. Should you need to change it (for example in case of serveral courses in the same place), you can pick another one clicking [PICK A GOLF RANGE]. All the courses in memory will popup and you can scroll and click on any of them.You can now tap the stepper [-/+] to see the distance of a hole or of the 3 next holes depending on the setup (see specific chapter).The map turns moving the hole to the center-top of your device and you can zoom in/out using the [slider] on the bottom of the screen."
    
    let page1 = "You can now tap the stepper [-/+] to see the distance of a hole or of the 3 next holes depending on the setup (see specific chapter).The map turns moving the hole to the center-top of your device and you can zoom in/out using the [slider] on the bottom of the screen.If 'free map' is activated you can zoom and move around as you wish using your fingers. Pressing [CENTER] (bottom-left of the screen) you will re-center the map on your position.\n\n\nMAPPING A NEW COURSE\n\nTap [Map Course] on the tab bar at the bottom of the screen to update, create or delete a course. Once touched, the screen shows all 18 holes and the distance to each of them if the course has been alredy mapped.\n\nTap on [Hole xx] to set it to the current position, the distance should become close to 0. Unfortunately the precison of the GPS can be 2m or worse, so it shows 0 very seldom. Pressing the button several time the precision increases because it is averaged on the previous registrations.\nThe hole is automatically saved under the current golf name.To create a new golf, just press [NEW] and add a name in the top row (mandatory) and other info's as you wish, than map all sigle holes.\n\nTouch [delete] to delete the golf with that name.\n\n Tap [Save] to save the entire golf course in case you need that."
    
    let page2 = "To create a new golf, just press [NEW] and add a name in the top row (mandatory) and other info's as you wish, than map all sigle holes.\n\nTouch [delete] to delete the golf with that name.\n\n Tap [Save] to save the entire golf course in case you need that.\n\n\nSETTING UP your device.\n\nYou can decide if yo use:\n [Meters or Yards]: for meters activate the switch.\n[Show 3 holes]: you will see on the gofl map the distance to the next 3 holes instead of one only. This helps when you are in the small courses, like driving ranges, where just a few holes are available, this avoid tyou to move the stepper every time.\n[Free Map]: if activated (suggested), you can zoom and move in the map using two fingers. If deactivated the golfer position is in the center of the map and the holes you chosed is moved toward the center top of the device, use the slider to zoom in out."
    
    let page3 = "FIRST USE : tap [Map Course] and enter a the name (mandatory) and other info's. Position youself in the center of each green and tap the correspondent [hole nn] to save it. There are a few courses loaded by default, you can cancel them after creating your fist one."
    
    let page4 = "This simple program was initially conceived to help mapping the small courses (driving ranges, pitch&putt etc.) forgotten by the main applications. Now it can manage entire 18 holes courses and it will be extended time after time.\n\nI started this project because I did not have anything to do in the middle of lock down and being retired since a few months. So I dedicated this time to learn Java (I did a program to read and manage databases) and later Swift and Xcode just for fun.\n\n\n Enjoy playing golf!"
    
    func createBook (){
        pages.append(page0)
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
    }
    
    @IBAction func nextTUI(_ sender: Any) {
        let n = pages.count
        if x < n - 1 {x += 1} else { return }
        lbl.text = pages[x]
    }
    
    @IBAction func backTUI(_ sender: Any) {
        if x > 0 {x -= 1} else { return }
        lbl.text = pages[x]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBook ()
        lbl.text = pages[0]
        
        //  scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: lbl.bottomAnchor).isActive =
        
        // Do any additional setup after loading the view.
    }
    
}
