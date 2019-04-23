//
//  FirstViewController.swift
//  JPSProject
//
//  Created by jps on 2019/2/18.
//  Copyright © 2019年 jps. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log.logPrint(34356)
        Log.errorPrint("hah")
        Log.wainingPrint(123)
        Log.testPrint(1,2,"哈")
        print(1,2,"哈")
    }
    

    

}
