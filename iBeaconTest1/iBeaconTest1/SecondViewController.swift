//
//  SecondViewController.swift
//  iBeaconTest1
//
//  Created by Jordy Matsari on 15/02/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var naarStationImageView: UIImageView!
    @IBOutlet var naarStationTextView: UITextView!
    
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    
    var lastInstruction = "hoi"
    
    let names = [ //text shown on screen when beacon is closest
        //36783: "KILz -> Rechts", //KILZ
        22239: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad daarna komt u bij de stoplichten", //KT80
        27120: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //vVmc
        //2376:  "zr3i", //zr3i
        //54482: "Chfq", //Chfq
        55620: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad daarna komt u bij de stoplichten", //WPYp
        41997: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //B5nr
        3992:  "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //XX1f
        24799: "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //icvL
    ]
    
    let images = [
        55620: "photo3",//WPYp
        41997: "photo4",//B5nr
        3992: "photo5",//XX1f
        22239: "photo3",//KT80
        27120: "photo4",//vVmc
        24799: "photo5"//icvL
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        self.naarStationTextView.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.naarStationTextView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
        self.naarStationTextView.text = "Welkom, zodra u bij een beacon in de buurt bent begint de route!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown && $0.proximity != CLProximity.Far}
        
        if (knownBeacons.count > 0){
            let closestBeacon = knownBeacons[0] as CLBeacon
            
            if((self.images[closestBeacon.minor.integerValue]) != nil){
                let locationImage = UIImage(named: self.images[closestBeacon.minor.integerValue]!)
                if(locationImage != nil){
                    self.naarStationImageView.image = locationImage
                }
            }
            self.naarStationTextView.text = self.names[closestBeacon.minor.integerValue]
            if(self.names[closestBeacon.minor.integerValue] != self.lastInstruction){
                UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.naarStationTextView.text)
                self.lastInstruction = self.names[closestBeacon.minor.integerValue]!
            }
        }
    }
}


