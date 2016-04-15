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
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Visios")
    
    var lastInstruction = "hoi"
    
    let instructions = [ //text shown on screen when beacon is closest
        //36783: "", //KILZ
        22239: "U blijft het trottoir volgen met aan de rechterhand een graslijn en aan de rechterhand een verkeersweg. Uw weg wordt onderbroken door een in- en uitrit van een hotel. Bij het Marriott hotel staat het gebouw van Adidas en Reebok.", //KT80
        27120: "U volgt het trottoir met grasrand als natuurlijke gidslijn. Tot u de volgende instructie ontvangt.", //vVmc
        //2376:  "", //zr3i
        //54482: "", //Chfq
        55620: "U steekt eerst het fietspad over en vervolgens verkeerslichten met dubbele oversteek, daarna volgt nog een fietspad. Eenmaal overgestoken volgt u de geleidelijn welke naar links afbuigt. U volgt het trottoir met aan uw rechterzijde het Bijenkorf gebouw. U kunt het gras als natuurlijke gidslijn gebruiken.", //WPYp
        //41997: "", //B5nr
        3992:  "Bij het verlaten van het pand gaat u linksaf en volgt u de geleidelijn, deze leidt u links om het gebouw van Visio heen. Aan het einde komt u uit op het voetpad.", //XX1f
        24799: "U nadert het viaduct. Volg de gidslijn tot u aan uw rechterhand een muur vindt, meteen aan de linkerzijde vindt u een geleidelijn die u naar de oversteek leidt. U steekt het fietspad over en steekt bij de verkeerslichten een dubbele verkeersweg over. Aan de overzijde kunt u de geleidelijn aanhouden die u volgt naar de ingang van het station.", //icvL
        //43166: "",//bqsy
        //34637: "",//XhPb
        31046: "U nadert een dwarsliggende trap, wees hier voorzichtig. Er ligt een geleidelijn die u kunt volgen en u om de trap heen leidt, waarna u het trottoir kunt vervolgen. Aan uw linkerzijde is er wederom een gebouw dat u als natuurlijke gidslijn kunt gebruiken.",//roGn
        //12271: "",//Vqm8
        63107: "U nadert een in- en uitrit van een parkeergarage. U heeft hier voorrang maar wees voorzichtig en maak u zichtbaar door uw herkenningsstok/taststok in te zetten. Aan uw linkerzijde is nog steeds het gebouw dat u als natuurlijke gidslijn kunt gebruiken.",//GcUL
        38177: "U bent de waterpartij voorbij. U loopt nu langs een groot gebouw aan uw linkerkant, dat u als gidslijn kan gebruiken.",//3DqG
        //63569: "",//StJV
        13828: "U slaat links af een voetpad op. Links van u is er een natuurlijke gidslijn in de vorm van een grasrand, deze wordt onderbroken door een inham en gaat even later over in een gebouw.",//PrbR
        12166: "Aan het einde komt u uit op het voetpad, u gaat rechtsaf en vervolgt het voetpad in de richting van de hoofdweg.",//bO9p
        //11032: "",//vSxj
    ]
    
    let instructionsExtra = [ //text shown on screen when beacon is closest
        //36783: "", //KILZ
        22239: "U volgt het trottoir met gidslijn. Uw weg wordt onderbroken door een in- en uitrit van een hotel.", //KT80
        27120: "U volgt het trottoir met grasrand als natuurlijke gidslijn.", //vVmc
        //2376:  "", //zr3i
        //54482: "", //Chfq
        55620: "U steekt bij de verkeerslichten met dubbele oversteek over, aan weerszijde is er een fietspad. Volg na het oversteken de geleidelijn tot de grasrand die kunt u daarna rechts aanhouden.", //WPYp
        //41997: "", //B5nr
        3992:  "U verlaat het pand, volg de geleidelijn naar links op het voetpad.", //XX1f
        24799: "U nadert een dubbele oversteek met verkeerslichten en fietspad. Steek over en volg daarna de geleidelijn tot aan de ingang van het station.", //icvL
        //43166: "",//bqsy
        //34637: "",//XhPb
        31046: "Wees alert, u nadert een dwarsliggende trap. Volg de geleidelijn om de trap heen daarna vervolgt u het trottoir met gidslijn.",//roGn
        //12271: "",//Vqm8
        63107: "Wees alert, U nadert een in -en uitrit van een parkeergarage.",//GcUL
        38177: "Houd het gebouw links van u aan als gidslijn",//3DqG
        //63569: "",//StJV
        13828: "U volgt een groenstrook met een inham en waterpartij aan uw linkerzijde.",//PrbR
        12166: "U slaat rechts af een voetpad op, met aan weerzijde een graslijn.",//bO9p
        //11032: "",//vSxj
    ]
    
    let images = [
        55620: "NV_WPYp",//WPYp
        //41997: "NV_B5nr",//B5nr
        3992:  "NV_XX1f",//XX1f
        22239: "NV_KT80",//KT80
        27120: "NV_vVmc",//vVmc
        24799: "NV_icvL",//icvL
        //43166: "NV_bqsy",//bqsy
        //34637: "NV_XhPb",//XhPb
        31046: "NV_roGn",//roGn
        //12271: "NV_Vqm8",//Vqm8
        63107: "NV_GcUL",//GcUL
        38177: "NV_3DqG",//3DqG
        //63569: "NV_StJV",//StJV
        13828: "NV_PrbR",//PrbR
        12166: "NV_b09p",//bO9p
        //11032: "NV_vSxj",//vSxj
        //54482: "NV_Chfq"//Chfq
    ]
    /*
    let imagesContrast = [
        55620: "NV_WPYp_C",//WPYp
        //41997: "NV_B5nr_C",//B5nr
        3992:  "NV_B5nr_C",//XX1f
        22239: "NV_KT80_C",//KT80
        27120: "NV_vVmc_C",//vVmc
        24799: "NV_icvL_C",//icvL
        //43166: "NV_bqsy_C",//bqsy
        //34637: "NV_XhPb_C",//XhPb
        31046: "NV_roGn_C",//roGn
        //12271: "NV_Vqm8_C",//Vqm8
        63107: "NV_GcUL_C",//GcUL
        38177: "NV_3DqG_C",//3DqG
        //63569: "NV_StJV_C",//StJV
        13828: "NV_PrbR_C",//PrbR
        12166: "NV_b09p_C",//bO9p
        //11032: "NV_vSxj_C",//vSxj
        //54482: "NV_Chfq_C"//Chfq
    ]
    */
    
    var preferences = [false,false,false,false]
    
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
                let locationImage = UIImage(named: self.images[closestBeacon.minor.integerValue]!)
                /*if(self.preferences[1] == true && self.imagesContrast[closestBeacon.minor.integerValue] != nil){
                NSLog(String(self.preferences[0]))
                locationImage = UIImage(named: self.imagesContrast[closestBeacon.minor.integerValue]!)
                }*/
                if(locationImage != nil){
                    self.naarStationImageView.image = locationImage
                }
            }
            if(self.instructions[closestBeacon.minor.integerValue] != nil){
                self.naarStationTextView.text = self.instructions[closestBeacon.minor.integerValue]
                if(self.preferences[0] == true && self.instructionsExtra[closestBeacon.minor.integerValue] != ""){
                    self.naarStationTextView.text = self.instructionsExtra[closestBeacon.minor.integerValue]
                }
                if(self.instructions[closestBeacon.minor.integerValue] != self.lastInstruction){
                    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.naarStationTextView.text)
                    self.lastInstruction = self.naarStationTextView.text
                }
            }
        }
    }
}


