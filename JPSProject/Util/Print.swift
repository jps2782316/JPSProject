//
//  Print.swift
//  JPSProject
//
//  Created by jps on 2019/2/19.
//  Copyright © 2019年 jps. All rights reserved.
//

import Foundation


//调试信息打印
//https://juejin.im/post/5af16664518825673954b03e Swift调试小技巧

//Swift学习之泛型: https://www.jianshu.com/p/6624f5365745


class Log {
    
    /*
     #file    String    包含这个符号的文件的路径
     #line    Int    符号出现处的行号
     #column    Int    符号出现处的列
     #function    String    包含这个符号的方法名字
     */
    
    
    //多个参数，用...
    static func testPrint(_ items: Any...) {
        let arr = items
        print(arr)
    }
    
    
    enum PrintType {
        //在编码的时候，我们应该尽量避免使用关键字，但如果我们必须使用 Swift 中的关键字时，可以用反引号（`）将关键词包住
        case `default`
        case error
        case warning
    }
    
    
    //泛型能够让开发者编写自定义需求以及任意类型的灵活可用的的函数和类型。能够让我们避免重复的代码。用一种清晰和抽象的方式来表达代码的意图。
    static func logPrint<T>(_ message: T,
                   printType: PrintType = .default,
                   file: String = #file,
                   method: String = #function,
                   line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent//.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "/" + "\(line)" + "/" +  method + ": " + "\(message)" + "\n")
        #endif
    }
    
    
    ///打印警告信息
    static func wainingPrint<T>(_ message: T,
                          file: String = #file,
                          method: String = #function,
                          line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let info = fileName + "/" + "\(line)" + "/" +  method + ": "
        let prefix = prefixStr(type: .warning)
        print(info + prefix + "\(message)" + "\n")
        #endif
    }
    
    ///打印警告信息
    static func errorPrint<T>(_ message: T,
                                file: String = #file,
                                method: String = #function,
                                line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let info = fileName + "/" + "\(line)" + "/" +  method + ": "
        let prefix = prefixStr(type: .error)
        print(info + prefix + "\(message)" + "\n")
        #endif
    }
    
    
    private class func prefixStr(type: PrintType) -> String {
        switch type {
        case .warning:
            //Emoji 键盘的呼出非常简单，只需记住这个快捷键组合即可：Command + Control + Spacebar（空格）
            let prefix = "⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️"
            return prefix
        case .error:
            let prefix = "👿👿👿👿👿👿👿👿"
            return prefix
        default:
            return ""
        }
    }
    
    
    
    
    
    
}

