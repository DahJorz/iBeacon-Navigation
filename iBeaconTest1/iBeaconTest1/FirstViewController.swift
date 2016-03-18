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
    
    @IBOutlet var instruction: UILabel!
    
    @IBOutlet var accuracy: UILabel!
    
    //"F7826DA6-4FA2-4E98-8024-BC5B71E0893E" Visio beacons
    //"74278BDA-B644-4520-8F0C-720EAF059935" Joey's beacons
    //"B9407F30-F5F8-466E-AFF9-25556B57FE6D" Joey's beacons2
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    let colors = [ //color on screen when beacon is closest
        36783: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),    //KILz
        22239: UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1),    //KT80
        27120: UIColor(red: 154/255, green: 65/255, blue: 183/255, alpha: 1), //vVmc
        //2376:  UIColor(red: 33/255, green: 183/255, blue: 55/255, alpha: 1),  //zr3i
        //54482: UIColor(red: 0/255, green: 255/255, blue:255/255, alpha: 1),    //Chfq
        //55620: UIColor(red: 255/255, green: 255/255, blue:0/255, alpha: 1),    //WPYp
        //41997: UIColor(red: 128/255, green: 0/255, blue:0/255, alpha: 1),      //B5nr
        3992: UIColor(red: 249/255, green: 163/255, blue:11/255, alpha: 1),    //XX1f
        24799: UIColor(red: 0/255, green: 128/255, blue:128/255, alpha: 1),    //icvL
        29: UIColor(red: 255/255, green: 0/255, blue:0/255, alpha: 1),
        30: UIColor(red: 0/255, green: 255/255, blue:0/255, alpha: 1),
        27: UIColor(red: 0/255, green: 0/255, blue:255/255, alpha: 1)
    ]
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
        29: "1", //joey
        30: "2", //joey
        27: "3"  //joey
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
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown && $0.proximity != CLProximity.Far}
        
        if (knownBeacons.count > 0){
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            //label.text = self.names[closestBeacon.minor.integerValue]
            //let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            //label.center = CGPointMake(160, 284)
            //label.textAlignment = NSTextAlignment.Center
            //label.text = self.names[closestBeacon.minor.integerValue]
            instruction.text = self.names[closestBeacon.minor.integerValue]
            
            //label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            //label.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
            if(closestBeacon.proximity == CLProximity.Near){
                accuracy.text = "Near"}
            if(closestBeacon.proximity == CLProximity.Immediate){
                accuracy.text = "Immediate"
            }
            
            //let accuracyInMeters = String(knownBeacons[0].proximity)
            //let accuracyText = String(accuracyInMeters)
            //accuracy.text = accuracyInMeters
            //label.removeFromSuperview()
            //self.view.addSubview(label)
            //self.subview.label.text = ""
        }
    }
}

