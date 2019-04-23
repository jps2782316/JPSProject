//
//  RootTabBarController.swift
//  JPSProject
//
//  Created by jps on 2019/2/18.
//  Copyright © 2019年 jps. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadControllers()
    }
    
    
    //1.控制器有多种初始化方式
    func loadControllers() {
        
        //let pickUpController = UIStoryboard.init(name: "DriftBottle", bundle: nil).instantiateViewController(withIdentifier: "YLPickUpBottleViewController") as? YLPickUpBottleViewController
        
        let VC1 = FirstViewController.viewControllerFromStoryboard("First", identifier: "FirstViewController") as! FirstViewController
        let VC2 = SecondViewController.controller()
        let VC3 = ThirdViewController()
        
        
        let navis = [UINavigationController(rootViewController: VC1),
                     UINavigationController(rootViewController: VC2),
                     UINavigationController(rootViewController: VC3)]
        
        
        let titles = ["First",
                      "Second",
                      "Third"]
        
        let images = ["tab_icon_friend_normal",
                      "tab_icon_quiz_normal",
                      "tab_icon_news_normal"]
        
        let selectedImages = ["tab_icon_friend_press",
                              "tab_icon_quiz_press",
                              "tab_icon_news_press"]
        
        
        for (index, controller) in navis.enumerated() {
            
            controller.tabBarItem.image = UIImage.init(named: images[index])?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.title = titles[index]
            controller.tabBarItem.selectedImage = UIImage(named: selectedImages[index])
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        }
        
        self.viewControllers = navis
        
    }
    
    
    
    //2.反射方式创建
    func loadViewControllers2() {
        
        let controllerNames = ["FirstViewController",
                               "SecondViewController",
                               "ThirdViewController"]
        
        let titles = ["First",
                      "Second",
                      "Third"]
        
        let images = ["tab_icon_friend_normal",
                      "tab_icon_quiz_normal",
                      "tab_icon_news_normal"]
        
        let selectedImages = ["tab_icon_friend_press",
                              "tab_icon_quiz_press",
                              "tab_icon_news_press"]
        
        
        let projectName = projectNameFromPlist()
        for i in 0..<controllerNames.count {
            let cls = NSClassFromString(projectName + "." + controllerNames[i]) as! UIViewController.Type
            let viewController = cls.init()
            viewController.title = titles[i]
            viewController.tabBarItem.image = UIImage(named: images[i])
            viewController.tabBarItem.selectedImage = UIImage(named: selectedImages[i])
            let navi = UINavigationController(rootViewController: viewController)
            self.addChild(navi)
        }
    }

    //获取工程名
    func projectNameFromPlist() -> String {
        //plist
        let plist = Bundle.main.infoDictionary
        let projectName = plist!["CFBundleName"]
        return projectName as! String
    }
    
    
    
    
    
    
    
    
    //----------------------------------------------------------
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        if let vc = selectedViewController {
            return vc.preferredStatusBarStyle
        }
        return UIApplication.shared.statusBarStyle
    }
    
    override var shouldAutorotate: Bool {
        if let vc = selectedViewController {
            return vc.shouldAutorotate
        }
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let vc = selectedViewController {
            return vc.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        
        if let vc = selectedViewController {
            return vc.preferredInterfaceOrientationForPresentation
        }
        return UIInterfaceOrientation.portrait
    }
    
    override var childForStatusBarStyle: UIViewController? {
        
        return selectedViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return selectedViewController
    }
    
//    override var childViewControllerForStatusBarStyle: UIViewController? {
//        
//        return selectedViewController
//    }
//    
//    override var childViewControllerForStatusBarHidden: UIViewController? {
//        return selectedViewController
//    }
    
    
    

}
