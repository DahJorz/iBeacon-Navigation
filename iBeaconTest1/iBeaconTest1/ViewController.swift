//
//  ViewController.swift
//  iBeaconTest1
//
//  Created by Mijnisha Singh on 23/03/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("PageOneViewController"){
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
