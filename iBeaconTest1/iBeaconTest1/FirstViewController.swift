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
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    
    var lastInstruction = "hoi"
    
    let instructions = [ //text shown on screen when beacon is closest
        //36783: "KILz -> Rechts", //KILZ
        22239: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad over, daarna komt u bij de stoplichten", //KT80
        27120: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //vVmc
        //2376:  "zr3i", //zr3i
        //54482: "Chfq", //Chfq
        //55620: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad daarna komt u bij de stoplichten", //WPYp
        //41997: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //B5nr
        //3992:  "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //XX1f
        24799: "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //icvL
        43166: "bla1",//bqsy
        34637: "bla2",//XhPb
        31046: "bla3",//roGn
        12271: "bla4",//Vqm8
        63107: "bla5",//GcUL
        38177: "bla6",//3DqG
        63569: "bla7",//StJV
        13828: "bla8",//PrbR
        12166: "bla9",//bO9p
        11032: "bla10",//vSxj
        54482: "Chfq"//Chfq
    ]
    
    let instructionsExtra = [ //text shown on screen when beacon is closest
        //36783: "KILz -> Rechts", //KILZ
        22239: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad over, daarna komt u bij de stoplichten", //KT80
        27120: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //vVmc
        //2376:  "zr3i", //zr3i
        //54482: "Chfq", //Chfq
        //55620: "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad daarna komt u bij de stoplichten", //WPYp
        //41997: "U steekt het fietspad weer over, volgt de geleidelijn. U kunt hier het DTG gebouw aan uw rechterhand als gidslijn gebruiken", //B5nr
        //3992:  "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //XX1f
        24799: "U bent nu aangekomen bij Visio, u kunt u melden bij de receptie.", //icvL
        43166: "bla1",//bqsy
        34637: "bla2",//XhPb
        31046: "bla3",//roGn
        12271: "bla4",//Vqm8
        63107: "bla5",//GcUL
        38177: "bla6",//3DqG
        63569: "bla7",//StJV
        13828: "bla8",//PrbR
        12166: "bla9",//bO9p
        11032: "bla10",//vSxj
        54482: "super lange tekst :D"//Chfq
    ]
    
    let images = [
        //55620: "NV_WPYp",//WPYp
        //41997: "NV_B5nr",//B5nr
        //3992: "NV_XX1f",//XX1f
        22239: "NV_KT80",//KT80
        27120: "NV_vVmc",//vVmc
        24799: "NV_icvL",//icvL
        43166: "NV_bqsy",//bqsy
        34637: "NV_XhPb",//XhPb
        31046: "NV_roGn",//roGn
        12271: "NV_Vqm8",//Vqm8
        63107: "NV_GcUL",//GcUL
        38177: "NV_3DqG",//3DqG
        63569: "NV_StJV",//StJV
        13828: "NV_PrbR",//PrbR
        12166: "NV_b09p",//bO9p
        11032: "NV_vSxj",//vSxj
        54482: "NV_Chfq"//Chfq
    ]
    
    let imagesContrast = [
        //55620: "NV_WPYp_C",//WPYp
        //41997: "NV_B5nr_C",//B5nr
        //3992: "NV_B5nr_C",//XX1f
        22239: "NV_KT80_C",//KT80
        27120: "NV_vVmc_C",//vVmc
        24799: "NV_icvL_C",//icvL
        43166: "NV_bqsy_C",//bqsy
        34637: "NV_XhPb_C",//XhPb
        31046: "NV_roGn_C",//roGn
        12271: "NV_Vqm8_C",//Vqm8
        63107: "NV_GcUL_C",//GcUL
        38177: "NV_3DqG_C",//3DqG
        63569: "NV_StJV_C",//StJV
        13828: "NV_PrbR_C",//PrbR
        12166: "NV_b09p_C",//bO9p
        11032: "NV_vSxj_C",//vSxj
        54482: "NV_Chfq_C"//Chfq
    ]
    
    var preferences = [false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
        self.naarVisioTextView.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.naarVisioTextView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
        self.naarVisioTextView.text = "Welkom, zodra u bij een beacon in de buurt bent begint de route!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        self.defaults = NSUserDefaults.standardUserDefaults()
        if (self.defaults.objectForKey("extraState") != nil) {
            self.preferences[0] = self.defaults.boolForKey("extraState")
        }
        if (self.defaults.objectForKey("contrastState") != nil) {
            self.preferences[1] = self.defaults.boolForKey("contrastState")
        }
        if (defaults.objectForKey("timeState") != nil) {
            self.preferences[2] = self.defaults.boolForKey("timeState")
        }
        if (defaults.objectForKey("distanceState") != nil) {
            self.preferences[3] = self.defaults.boolForKey("distanceState")
        }
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown && $0.proximity != CLProximity.Far}
        
        if (knownBeacons.count > 0){
            let closestBeacon = knownBeacons[0] as CLBeacon
            
            if((self.images[closestBeacon.minor.integerValue]) != nil){
                var locationImage = UIImage(named: self.images[closestBeacon.minor.integerValue]!)
                if(self.preferences[1] == true){
                    NSLog(String(self.preferences[0]))
                    locationImage = UIImage(named: self.imagesContrast[closestBeacon.minor.integerValue]!)
                }
                if(locationImage != nil){
                    self.naarVisioImageView.image = locationImage
                }
            }
            if(self.instructions[closestBeacon.minor.integerValue] != nil){
                self.naarVisioTextView.text = self.instructions[closestBeacon.minor.integerValue]
                if(self.preferences[0] == true){
                    self.naarVisioTextView.text = self.instructionsExtra[closestBeacon.minor.integerValue]
                }
                if(self.instructions[closestBeacon.minor.integerValue] != self.lastInstruction){
                    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.naarVisioTextView.text)
                    self.lastInstruction = self.naarVisioTextView.text
                }
            }
        }
    }
}

