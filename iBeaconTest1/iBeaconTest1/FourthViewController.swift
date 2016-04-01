//
//  FourthViewController.swift
//  iBeaconTest1
//
//  Created by Jordy Matsari on 16/03/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var previewText: UITextView!
    
    let images = [
        "firstCrossingContrast2",//weird ass beacon doesn't work
        "firstCrossing",
        "firstCrossingContrast",
        "firstCrossingContrast2",//weird ass beacon doesn't work
        "firstCrossing",
        "firstCrossingContrast"
    ]
    //should contain as many entries as images
    let instructions = [ //text shown on screen when beacon is closest
        "1", //KILZ
        "2", //KT80
        "3", //vVmc
        "4", //XX1f
        "5", //icvL
    ]
    
    var previewIndex = 0
    
    var locationImage = UIImage(named: "second")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        upSwipe.direction = .Up
        downSwipe.direction = .Down
    
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        if(UIImage(named: self.images[previewIndex]) != nil){
            locationImage = UIImage(named: self.images[previewIndex])
            
            if(locationImage != nil){
                self.previewImage.image = locationImage
                self.previewText.text = instructions[previewIndex]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left || sender.direction == .Up) {
            if(previewIndex<instructions.count-1){
                previewIndex++
            } else {
                previewIndex = 0
            }
            
            if(UIImage(named: self.images[previewIndex]) != nil){
                locationImage = UIImage(named: self.images[previewIndex])
            
                if(locationImage != nil){
                    self.previewImage.image = locationImage
                    self.previewText.text = instructions[previewIndex]
                }
            }
        }
        
        if (sender.direction == .Right || sender.direction == .Down) {
            if(previewIndex>0){
                previewIndex--
            } else {
                previewIndex = instructions.count-1
            }
            
            if(UIImage(named: self.images[previewIndex]) != nil){
                locationImage = UIImage(named: self.images[previewIndex])
                
                if(locationImage != nil){
                    self.previewImage.image = locationImage
                    self.previewText.text = instructions[previewIndex]
                }
            }
        }
    }
}

