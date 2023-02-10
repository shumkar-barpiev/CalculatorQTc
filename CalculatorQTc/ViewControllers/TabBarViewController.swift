//
//  TabBarViewController.swift
//  CalculatorQTc
//
//  Created by User on 8/2/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeTabbarCorner()
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       self.changingHeightTabbar()
       
   }
   
   func changeTabbarCorner(){
       self.tabBar.layer.masksToBounds = true
       self.tabBar.isTranslucent = true
       self.tabBar.layer.cornerRadius = 30
       self.tabBar.layer.shadowColor = UIColor.black.cgColor
       self.tabBar.layer.shadowOffset = .zero
       self.tabBar.layer.shadowOpacity = 0.5
       self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
   }
   
   
   func changingHeightTabbar(){
       if UIDevice().userInterfaceIdiom == .phone{
           var tabFrame = tabBar.frame
           tabFrame.size.height = 100
           tabFrame.origin.y = view.frame.size.height - 100
           tabBar.frame = tabFrame
       }
   }
   

}
