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
        27120: "U volgt het trottoir met natuurlijke gidslijn straks mee naar links tot geleidelijn. De geleidelijn volgt u naar de oversteek", //vVmc
        41997: "U steekt eerst het fietspad over en vervolgens verkeerslichten met dubbele oversteek, daarna volgt nog een fietspad.", //B5nr
        3992:  "U bent aangekomen bij Visio. U kunt u melden bij de receptie. U loopt door de twee schuifdeuren naar binnen, de receptie is aan de linkerkant.", //XX1f
        43166: "U steekt bij de verkeerslichten een dubbele verkeersweg over en aansluitend een fietspad. Eenmaal overgestoken volgt u de geleidelijn naar rechts.",//bqsy
        34637: "U nadert een dwarsliggende trap, wees hier voorzichtig. Er ligt een geleidelijn die u kunt volgen en u om de trap heen leidt, waarna u het trottoir kunt vervolgen. Aan uw rechterzijde is er wederom een gebouw dat u als natuurlijke gidslijn kunt gebruiken.",//XhPb
        12271: "U nadert een in- en uitrit van een parkeergarage. U heeft hier voorrang maar wees voorzichtig en maak u zichtbaar door uw herkenningsstok/taststok in te zetten. Aan uw rechterzijde is nog steeds het gebouw dat u als natuurlijke gidslijn kunt gebruiken.",//Vqm8
        38177: "Het gebouw aan uw rechterzijde loopt ten einde. U volgt een groenstrook met een inham en waterpartij aan uw rechterzijde.",//3DqG
        63569: "Wees alert uw weg wordt onderbroken door een in- en uitrit van een hotel. Bij het Marriott hotel staat het gebouw van Adidas en Reebok. U blijft het trottoir volgen met aan de linkerhand een grasrand als natuurlijke gidslijn. De grasrand wordt 3 keer onderbroken.",//StJV
        13828: "U slaat rechts af een voetpad op, met aan weerzijde een natuurlijke gidslijn. U loopt een gebouw voorbij.",//PrbR
        12166: "U volgt het voetpad naar links, vanaf hier kunt u de geleidelijn volgen. U staat nu voor het gebouw van Visio de geleidelijn buigt straks naar rechts.",//bO9p
        //11032: "",//vSxj
        //36783: "", //KILZ
        //22239: "", //KT80
        //63107: "",//GcUL
        //31046: "",//roGn
        24799: "U blijft het trottoir volgen met aan de linkerhand een grasrand als natuurlijke gidslijn. U loopt langs het Atlas Arena gebouw. De grasrand wordt 3 keer onderbroken.", //icvL
        2376:  "Eenmaal overgestoken volgt u de geleidelijn welke naar links afbuigt. U volgt het trottoir met aan uw rechterzijde het DTG gebouw dat u als natuurlijke gidslijn kunt gebruiken.", //zr3i
        //54482: "", //Chfq
        //55620: "", //WPYp
    ]
    
    let instructionsExtra = [ //text shown on screen when beacon is closest
        27120: "U volgt het trottoir met grasrand als natuurlijke gidslijn. De grasrand wordt 3 keer onderbroken.", //vVmc
        41997: "U steekt bij de verkeerslichten over. Eenmaal overgestoken slaat u links af en blijft u het trottoir volgen met gidslijn.", //B5nr
        3992:  "U bent aangekomen bij Visio. U kunt u melden bij de receptie.", //XX1f
        43166: "U nadert een dubbele oversteek met verkeerslichten en fietspad. Steek over, u blijft het trottoir volgen met aan de linkerhand een grasrand als natuurlijke gidslijn.",//bqsy
        34637: "Wees alert, u nadert een dwarsliggende trap. Volg de geleidelijn om de trap heen daarna vervolgt u het trottoir met gidslijn.",//XhPb
        12271: "Wees alert, u nadert een in- en uitrit van een parkeergarage.",//Vqm8
        38177: "U volgt een groenstrook met een inham en waterpartij aan uw rechterzijde.",//3DqG
        63569: "Uw weg wordt onderbroken door een in- en uitrit van een hotel. U volgt het trottoir met de gidslijn. De grasrand wordt 3 keer onderbroken.",//StJV
        13828: "U slaat rechts af een voetpad op, met aan weerzijde een natuurlijke gidslijn.",//PrbR
        12166: "U volgt het voetpad naar links, vanaf hier kunt u de geleidelijn volgen.",//bO9p
        //11032: "",//vSxj
        //36783: "", //KILZ
        //22239: "", //KT80
        //63107: "",//GcUL
        //31046: "",//roGn
        //24799: "", //icvL
        //2376:  "", //zr3i
        //54482: "", //Chfq
        //55620: "", //WPYp
    ]
    
    let images = [
        //55620: "NV_WPYp",//WPYp
        41997: "NV_B5nr",//B5nr
        3992: "NV_XX1f",//XX1f
        //22239: "NV_KT80",//KT80
        27120: "NV_vVmc",//vVmc
        24799: "NV_bqsy",//icvL
        43166: "NV_bqsy",//bqsy
        34637: "NV_XhPb",//XhPb
        //31046: "NV_roGn",//roGn
        12271: "NV_Vqm8",//Vqm8
        //63107: "NV_GcUL",//GcUL
        38177: "NV_3DqG",//3DqG
        63569: "NV_StJV",//StJV
        13828: "NV_PrbR",//PrbR
        12166: "NV_bO9p",//bO9p
        //11032: "NV_vSxj",//vSxj
        //54482: "",//Chfq,
        2376: "NV_B5nr"//zr3i
    ]
    
    /*
    let imagesContrast = [
        //55620: "NV_WPYp_C",//WPYp
        41997: "NV_B5nr_C",//B5nr
        3992: "NV_B5nr_C",//XX1f
        //22239: "NV_KT80_C",//KT80
        27120: "NV_vVmc_C",//vVmc
        //24799: "NV_icvL_C",//icvL
        43166: "NV_bqsy_C",//bqsy
        34637: "NV_XhPb_C",//XhPb
        //31046: "NV_roGn_C",//roGn
        12271: "NV_Vqm8_C",//Vqm8
        //63107: "NV_GcUL_C",//GcUL
        38177: "NV_3DqG_C",//3DqG
        63569: "NV_StJV_C",//StJV
        13828: "NV_PrbR_C",//PrbR
        12166: "NV_bO9p_C",//bO9p
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
        
        self.naarVisioTextView.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.naarVisioTextView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
        self.naarVisioTextView.text = "De route die u naar Visio leidt begint als u een Beacon nadert. Deze begint bij het eerste stoplicht, nadat u het busstation voorbij bent gelopen."
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
                    self.naarVisioImageView.image = locationImage
                }
            }
            if(self.instructions[closestBeacon.minor.integerValue] != nil){
                self.naarVisioTextView.text = self.instructions[closestBeacon.minor.integerValue]
                if(self.preferences[0] == true && self.instructionsExtra[closestBeacon.minor.integerValue] != ""){
                    self.naarVisioTextView.text = self.instructionsExtra[closestBeacon.minor.integerValue]
                }
                if(self.naarVisioTextView.text != self.lastInstruction){
                    NSLog(String(tabBarController!.selectedIndex))
                    if(String(tabBarController!.selectedIndex) == "0"){
                        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.naarVisioTextView.text)                    }
                    self.lastInstruction = self.naarVisioTextView.text
                }
            }
        }
    }
}

