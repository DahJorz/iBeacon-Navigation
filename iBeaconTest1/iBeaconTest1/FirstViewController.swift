//
//  FirstViewController.swift
//  iBeaconTest1
//
//  Created by Jordy Matsari on 15/02/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var naarVisioTextView: UITextView!
    @IBOutlet var naarVisioImageView: UIImageView!
    
    @IBOutlet var instruction: UILabel!
    @IBOutlet var accuracy: UILabel!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    
    let names = [ //text shown on screen when beacon is closest
        36783: "KILz -> Rechts", //KILZ
        22239: "KT80 -> Links", //KT80
        27120: "vVmc -> Rechts", //vVmc
        //2376:  "zr3i", //zr3i
        //54482: "Chfq", //Chfq
        //55620: "WPYp", //WPYp
        //41997: "B5nr", //B5nr
        3992:  "XX1f -> Rechts", //XX1f
        24799: "icvL -> Rechts", //icvL
    ]
    
    let images = [
        27120: "firstCrossing",
        36783: "firstCrossingContrast2",//weird ass beacon doesn't work
        22239: "firstCrossingContrast"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        self.naarVisioTextView.textColor = UIColor(red: 255/255, green: 255/255, blue:0/255, alpha: 1)
        self.naarVisioTextView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:255/255, alpha: 1)
        self.naarVisioTextView.text = "Welkom, zodra u bij een beacon in de buurt bent begint de route!"
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
                    self.naarVisioImageView.image = locationImage
                }
            }
            self.naarVisioTextView.text = self.names[closestBeacon.minor.integerValue]
        }
    }
}

