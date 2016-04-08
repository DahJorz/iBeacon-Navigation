//
//  SettingsController.swift
//  VisioBeacons
//
//  Created by Jordy Matsari on 08/04/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    @IBOutlet var extraSwitch: UISwitch!
    @IBOutlet var contrastSwitch: UISwitch!
    @IBOutlet var timeSwitch: UISwitch!
    @IBOutlet var distanceSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.objectForKey("extraSate") != nil) {
            extraSwitch.on = defaults.boolForKey("extraState")
        }
        if (defaults.objectForKey("contrastState") != nil) {
            extraSwitch.on = defaults.boolForKey("contrastState")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    @IBAction func saveSwitchState(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if extraSwitch.on {
            defaults.setBool(true, forKey: "extraState")
        } else {
            defaults.setBool(false, forKey: "extraState")
        }
        
        if contrastSwitch.on {
            defaults.setBool(true, forKey: "contrastState")
        } else {
            defaults.setBool(false, forKey: "contrastState")
        }
        
    }
}
