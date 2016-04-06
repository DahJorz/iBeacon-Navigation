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
        "photo1",//WPYp
        "photo2",//B5nr
        "photo3",//Chfq
        "photo4",//XX1f
        "photo5" //
    ]
    
    //should contain as many entries as images
    let instructions = [ //text shown on screen when beacon is closest
        "Zodra u de schuifdeur van de stationshal passeert, slaat u links af. Hier kunt u de geleidelijn volgen tot aan het stoplicht. Het busstation is rechts van u en links is er een sportschool",//WPYp
        "Volg de geleidelijn, sla rechtsaf en volg de natuurlijke geleidelijn aan uw linkerhand. Aan de linkerhand is het atlas gebouw",//B5nr
        "U loopt nu langs de Bijenkorf. Volg de gidslijn straks naar links, waarna u de geleidelijn kunt volgen naar het stoplicht. ",//Chfq
        "Wees alert, dit is een stoplicht met dubbele oversteek met fietspad. U steekt hier eerst het fietspad daarna komt u bij de stoplichten", //XX1f
        "U bent nu aangekomen bij Visio", //
    ]
    var previewIndex = 0
    
    var locationImage = UIImage(named: "second")
    var lastInstruction = "hoi"

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
                if(self.instructions[previewIndex] != self.lastInstruction){
                    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, String(self.instructions[previewIndex]))
                    self.lastInstruction = self.instructions[previewIndex]
                }
            }
        }
        
        self.previewText.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.previewText.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
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
                    if(self.instructions[previewIndex] != self.lastInstruction){
                        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.instructions[previewIndex])
                        self.lastInstruction = self.instructions[previewIndex]
                    }
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
                    if(self.instructions[previewIndex] != self.lastInstruction){
                        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.instructions[previewIndex])
                        self.lastInstruction = self.instructions[previewIndex]
                    }
                }
            }
        }
    }
}

