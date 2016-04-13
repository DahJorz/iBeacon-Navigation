//
//  SettingsViewController.swift
//  VisioBeacons
//
//  Created by Jordy Matsari on 13/04/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var extraSwitch: UISwitch!
    @IBOutlet var contrastSwitch: UISwitch!
    @IBOutlet var timeSwitch: UISwitch!
    @IBOutlet var distanceSwitch: UISwitch!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.objectForKey("extraState") != nil) {
            extraSwitch.on = defaults.boolForKey("extraState")
        }
        if (defaults.objectForKey("contrastState") != nil) {
            contrastSwitch.on = defaults.boolForKey("contrastState")
        }
        if (defaults.objectForKey("timeState") != nil) {
            timeSwitch.on = defaults.boolForKey("timeState")
        }
        if (defaults.objectForKey("distanceState") != nil) {
            distanceSwitch.on = defaults.boolForKey("distanceState")
        }
        
        extraSwitch.addTarget(self, action: "switchHandler:", forControlEvents: UIControlEvents.ValueChanged)
        contrastSwitch.addTarget(self, action: "switchHandler:", forControlEvents: UIControlEvents.ValueChanged)
        timeSwitch.addTarget(self, action: "switchHandler:", forControlEvents: UIControlEvents.ValueChanged)
        distanceSwitch.addTarget(self, action: "switchHandler:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func switchHandler(sender: AnyObject) {
        if extraSwitch.on {
            defaults.setBool(true, forKey: "extraState")
            NSLog("extraState true")
        } else {
            defaults.setBool(false, forKey: "extraState")
            NSLog("extraState false")
        }
        
        if contrastSwitch.on {
            defaults.setBool(true, forKey: "contrastState")
            NSLog("contrastState true")
        } else {
            defaults.setBool(false, forKey: "contrastState")
            NSLog("contrastState false")
        }
        
        if timeSwitch.on {
            defaults.setBool(true, forKey: "timeState")
            NSLog("timeState true")
        } else {
            defaults.setBool(false, forKey: "timeState")
            NSLog("timeState false")
        }
        
        if distanceSwitch.on {
            defaults.setBool(true, forKey: "distanceState")
            NSLog("distanceState true")
        } else {
            defaults.setBool(false, forKey: "distanceState")
            NSLog("distanceState false")
        }
    }
}
