//
//  TutorialPageViewController.swift
//  iBeaconTest1
//
//  Created by Mijnisha Singh on 23/03/16.
//  Copyright © 2016 Jordy Matsari. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrPageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets"];
        self.arrPagePhoto = ["1.jpg", "2.jpg", "3.jpg"];
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier(" ") as!
        UIPageViewController
        
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as ViewController
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward,
            animated: true, completion: nil)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        
        
        
        

    }
    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
//    {
//        let pageContent: ViewController = viewController as! ViewController
//        var index = pageContent.pageIndex
//        if ((index == 0) || (index == NSNotFound))
//        {
//            return nil
//        }
//        index--;
//        return getViewControllerAtIndex(index)
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
//    {
//        let pageContent: ViewController = viewController as! ViewController
//        var index = pageContent.pageIndex
//        if (index == NSNotFound)
//        {
//            return nil;
//        }
//        index++;
//        if (index == arrPageTitle.count)
//        {
//            return nil;
//        }
//        return getViewControllerAtIndex(index)
//    }
    
//    func getViewControllerAtIndex(index: NSInteger) -> ViewController
//    {
//        // Create a new view controller and pass suitable data.
//        let ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//        ViewController.strTitle = "\(arrPageTitle[index])"
//        ViewController.strPhotoName = "\(arrPagePhoto[index])"
//        ViewController.pageIndex = index
//        return ViewController
//    }
    
    func viewControllerAtIndex(index: Int) -> ViewController{
        
        if((self.arrPageTitle.count == 0 ) || (index >= self.arrPageTitle.count)){
            return ViewController()
        }
        
        var vc: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier(" ") as!
        ViewController
        
        vc.imageFile = self.arrPagePhoto[index] as! String
        vc.titleText = self.arrPageTitle[index] as! String
        vc.pageIndex = index
        
        return vc
    
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! ViewController
        var index = vc.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){
            return  nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound){
            return  nil
        }
        index++
        
        if( index == self.arrPageTitle.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.arrPageTitle.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
