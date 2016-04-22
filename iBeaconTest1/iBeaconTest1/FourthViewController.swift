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
        "01_IMG_0444.JPG",
        "02_IMG_0228.JPG",
        "03_IMG_0445.JPG",
        "04_IMG_0446.JPG",
        "05_IMG_0447.JPG",
        "06_IMG_0449.JPG",
        "07_IMG_0451.JPG",
        "08_IMG_0453.JPG",
        "09_IMG_0225.JPG",
        "11_IMG_0236.JPG",
        "12_IMG_0385.JPG",
        "13_IMG_0389.JPG",
        "14_IMG_0391.JPG",
        "15_IMG_0397.JPG",
        "16_IMG_0395.JPG",
        "17_IMG_0257.JPG",
        "18_IMG_0265.JPG",
        "19_.JPG",
        "20_IMG_0477.JPG",
        "21_IMG_0426.JPG",
        "22_IMG_0280.JPG",
        "23_IMG_0431.JPG",
        "24_IMG_0438.JPG",
        "25_IMG_0287.JPG",
        "26_IMG_0440.JPG"
    ]
    
    let pageNumbers = [
        "1/25",
        "2/25",
        "3/25",
        "4/25",
        "5/25",
        "6/25",
        "7/25",
        "8/25",
        "9/25",
        "10/25",
        "11/25",
        "12/25",
        "13/25",
        "14/25",
        "15/25",
        "16/25",
        "17/25",
        "18/25",
        "19/25",
        "20/25",
        "21/25",
        "22/25",
        "23/25",
        "24/25",
        "25/25"
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
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
    ]
    var previewIndex = 0
    
    var locationImage = UIImage(named: "second")
    var lastInstruction = "hoi"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        previousButton.tag = 1
        nextButton.tag = 2
        previousButton.addTarget(self, action: #selector(self.buttonHandler(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.addTarget(self, action: #selector(self.buttonHandler(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        self.pageHandler()
        
        self.previewText.textColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
        self.previewText.backgroundColor = UIColor(red: 0/255, green: 0/255, blue:0/255, alpha: 1)
        self.previewText.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .Left || sender.direction == .Up) {
            self.indexHandler("next")
        } 
        
        if (sender.direction == .Right || sender.direction == .Down) {
            self.indexHandler("previous")
        }
    }
    
    func buttonHandler(sender:UIButton)
    {
        if(sender.tag == 2){
            self.indexHandler("next")
        }
        
        if(sender.tag == 1){
            self.indexHandler("previous")
        }
    }
    
    func indexHandler(direction: String){
        if (direction == "previous"){
            if(previewIndex>0){
                previewIndex -= 1
            } else {
                previewIndex = instructions.count-1
            }
        } else {
            if(previewIndex<instructions.count-1){
                previewIndex += 1
            } else {
                previewIndex = 0
            }
        }
        self.pageHandler()
    }
    
    func pageHandler(){
        if(UIImage(named: self.images[previewIndex]) != nil){
            locationImage = UIImage(named: self.images[previewIndex])
            
            if(locationImage != nil){
                self.previewImage.image = locationImage
                self.previewText.text = instructions[previewIndex]
                UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.previewText.text)
                self.lastInstruction = self.instructions[previewIndex]
                self.pageLabel.text = self.pageNumbers[previewIndex]
            }
        }
    }
}

