//
//  AppDelegate.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 修改整个框架tabbar的tintcolor
        UITabBar.appearance().tintColor = UIColor.orange
        
        // 设置状态栏为白色 先在info.plist 添加 View controller-based status bar appearance 然后加上下面这行代码
        application.statusBarStyle = .lightContent
        
    
        return true
    }





}

