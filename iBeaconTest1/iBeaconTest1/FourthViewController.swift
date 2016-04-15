//
//  FourthViewController.swift
//  iBeaconTest1
//
//  Created by Jordy Matsari on 16/03/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var previewText: UITextView!
    
    let images = [
        "NV_B5nr",//B5nr
        "NV_XX1f",//XX1f
        "NV_vVmc",//vVmc
        "NV_bqsy",//bqsy
        "NV_XhPb",//XhPb
        "NV_Vqm8",//Vqm8
        "second",//3DqG
        "NV_StJV",//StJV
        "NV_PrbR",//PrbR
        "NV_bO9p",//bO9p
    ]
    
    let pageNumbers = [
        "1/10",
        "2/10",
        "3/10",
        "4/10",
        "5/10",
        "6/10",
        "7/10",
        "8/10",
        "9/10",
        "10/10"
    ]
    
    //should contain as many entries as images
    let instructions = [ //text shown on screen when beacon is closest
        "U volgt het trottoir straks mee naar links. Daar pakt u de geleidelijn op richting de oversteek.", //vVmc
        "U steekt bij de verkeerslichten over. Eenmaal overgestoken slaat u links af en blijft u het trottoir volgen met gidslijn.", //B5nr
        "U bent aangekomen bij Visio. U kunt u melden bij de receptie.", //XX1f
        "U nadert een dubbele oversteek met verkeerslichten en fietspad. Steek over, u blijft het trottoir volgen met aan de linkerhand een grasrand als natuurlijke gidslijn.",//bqsy
        "Wees alert, u nadert een dwarsliggende trap. Volg de geleidelijn om de trap heen daarna vervolgt u het trottoir met gidslijn.",//XhPb
        "Wees alert, u nadert een in- en uitrit van een parkeergarage.",//Vqm8
        "U volgt een groenstrook met een inham en waterpartij aan uw rechterzijde.",//3DqG
        "U volgt het trottoir met de gidslijn. Uw weg wordt onderbroken door een in- en uitrit van een hotel.",//StJV
        "U slaat rechts af een voetpad op, met aan weerzijde een natuurlijke gidslijn.",//PrbR
        "U volgt het voetpad naar links, vanaf hier kunt u de geleidelijn volgen.",//bO9p
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
        
        previousButton.tag = 1
        nextButton.tag = 2
        previousButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
                    self.pageLabel.text = self.pageNumbers[previewIndex]
                }
            }
        }
        
        self.previewText.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.previewText.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
        self.previewText.becomeFirstResponder()
        //previousButton.isAccessibilityElement = false
        //nextButton.isAccessibilityElement = false
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
                        self.pageLabel.text = self.pageNumbers[previewIndex]
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
                        self.pageLabel.text = self.pageNumbers[previewIndex]
                    }
                }
            }
        }
    }
    
    func buttonHandler(sender:UIButton)
    {
        if(sender.tag == 2){
            sender.selected = false
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
                        self.pageLabel.text = self.pageNumbers[previewIndex]
                        //self.previewText.select(self.previewText)
                        //self.previewText.selectedTextRange = self.previewText.textRangeFromPosition(self.previewText.beginningOfDocument, toPosition: self.previewText.endOfDocument)
                    }
                }
            }
            
        }
        if(sender.tag == 1){
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
                    //if(self.instructions[previewIndex] != self.lastInstruction){
                        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.previewText.text)
                        self.lastInstruction = self.instructions[previewIndex]
                        self.pageLabel.text = self.pageNumbers[previewIndex]
                        //self.previewText.becomeFirstResponder()
                        //self.previewText.nextResponder()
                        //self.previewText.selectedTextRange = self.previewText.textRangeFromPosition(self.previewText.beginningOfDocument, toPosition: self.previewText.endOfDocument)
                    //}
                }
            }
        }
    }
}

