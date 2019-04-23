//
//  UIViewController+Storyboard.swift
//  JPSProject
//
//  Created by jps on 2019/2/18.
//  Copyright © 2019年 jps. All rights reserved.
//

import Foundation
import UIKit


//以协议的形式从storyboard加载一个控制器
protocol StoryboardProtocol {}
extension StoryboardProtocol where Self: UIViewController { //只有类为UIViewController时，才有此协议
    static func viewController(storyboardName: String, identifier: String? = nil) -> Self {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        var id = identifier
        if id == nil {
            let type = NSStringFromClass(self.classForCoder())
            id = type.components(separatedBy: ".").last
        }
        return storyboard.instantiateViewController(withIdentifier: id!) as! Self
    }
}
extension UIViewController: StoryboardProtocol {}









extension UIViewController {
    //从storyBoard加载一个控制器
    public static func viewControllerFromStoryboard(_ storyboardName: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    public static func viewControllerFromStoryboard(_ storyboardName:String) -> UIViewController {
        
        let type = NSStringFromClass(self.classForCoder())
        let identifier = type.components(separatedBy: ".").last
        return self.viewControllerFromStoryboard(storyboardName, identifier: identifier!)
    }
}








extension UIViewController {
    ///获取当前显示的VC
    public static func currentVC() -> UIViewController? {
        var result: UIViewController?
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                }
            }
        }
        
        let frontView = window?.subviews.first
        let nextResponse = frontView?.next
        if nextResponse is UIViewController {
            result = nextResponse as? UIViewController
        }
        else {
            result = window?.rootViewController
        }
        
        if result is UITabBarController {
            let tabbarVC = result as! UITabBarController
            result = tabbarVC.selectedViewController
        }
        
        if result is UINavigationController {
            let naviVC = result as! UINavigationController
            result = naviVC.visibleViewController
        }
        return result
    }
    
    //获取当前控制器 (递归？)
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}








extension UIViewController {
    ///pop到某一个指定的控制器
    class func pop(to aClass: AnyClass, navi: UINavigationController?, animated: Bool) -> Bool {
        var canPop = false
        guard let controllers = navi?.viewControllers else { return canPop }
        for controller in controllers {
            if controller.isKind(of: aClass) {
                DispatchQueue.main.async {
                    navi?.popToViewController(controller, animated: animated)
                }
                canPop = true
            }
        }
        return canPop
    }
}
