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
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    let colors = [
        36783: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),    //KILz
        22239: UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1),    //KT80
        27120: UIColor(red: 154/255, green: 65/255, blue: 183/255, alpha: 1)  //vVmc
    ]
    let names = [
        36783: "KILz", //KILZ
        22239: "KT80", //KT80
        27120: "vVmc"  //vVmc
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0){
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            //label.text = self.names[closestBeacon.minor.integerValue]
            let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            label.center = CGPointMake(160, 284)
            label.textAlignment = NSTextAlignment.Center
            label.text = self.names[closestBeacon.minor.integerValue]
            //label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            label.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
            //label.removeFromSuperview()
            self.view.addSubview(label)
            //self.subview.label.text = ""
        }
    }
}

