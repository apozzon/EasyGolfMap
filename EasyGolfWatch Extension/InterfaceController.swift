//
//  InterfaceController.swift
//  Test WatchKit Extension
//
//  Created by Andrea Pozzoni on 14/04/21.
//

import WatchKit
import Foundation
import WatchConnectivity



class InterfaceController: WKInterfaceController {
    
    // 1: Session property
    private var session = WCSession.default
    
    var holeNumber = 0
    
    
    @IBOutlet weak var lblDist: WKInterfaceLabel!
    
    @IBOutlet weak var lblHole: WKInterfaceLabel!
    
    
    
        @IBAction func swipeRight(_ sender: Any) {
            if holeNumber < 18 {holeNumber += 1} else {holeNumber = 1}
            lblHole.setText("Hole \(String(holeNumber))")
            
            talkToIphone ()
            
        }
        
        @IBAction func swipeLeft(_ sender: Any) {
            if holeNumber > 1 {holeNumber -= 1} else {holeNumber = 18}
            lblHole.setText("Hole \(String(holeNumber))")

            talkToIphone ()
        }
      
    
    @IBAction func updateDistance() {
        
        talkToIphone ()
        
    }
    
    func talkToIphone () {
        
        if isReachable() {
            
            // send a message asking for the distance of the hole n. holeNumber
            // the reply is the distance stored in the variable "restore" as "response.value"
            // the reply contains also the hole that was requested as "response.keys"
            session.sendMessage(["request" : "hole"+String(holeNumber)], replyHandler: { (response) in
                var dst = "\(response.values)"
                
                // elimino [] da messaggio di ritorno
                
                dst = dst.description.replacingOccurrences(of: "[", with: "")
                dst = dst.replacingOccurrences(of: "]", with: "")
                self.lblDist.setText("\(dst)")
                var hole = response.keys.description.replacingOccurrences(of: "[", with: "")
                hole = hole.replacingOccurrences(of: "]", with: "")
                hole = hole.replacingOccurrences(of: "\"", with: "")
                self.lblHole.setText("Hole \(hole)")
            }, errorHandler: { (error) in
                print("Error sending message: %@", error)
            })
        } else {
        print("iPhone is not reachable!!")
        }
        
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // 1: We launch a sound and a vibration
        WKInterfaceDevice.current().play(.notification)
        // 2: Get message and append to list
        let msg = message["msg"]!
        print(msg)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        

        // Configure interface objects here.

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // 2: Initialization of session and set as delegate this InterfaceController if it's supported
        if isSuported() {
            session.delegate = self
            session.activate()
            talkToIphone()  // trying to wake it up
            talkToIphone()
            
        } else {
        print("iPhone is not reachable!!")
        }
        
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func isSuported() -> Bool {
        return WCSession.isSupported()
    }
    
    private func isReachable() -> Bool {
        return session.isReachable
    }
}
extension InterfaceController: WCSessionDelegate {
    
    // 4: Required stub for delegating session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
    }
    
}

    

