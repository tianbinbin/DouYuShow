//
//  CustomViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class CustomViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 获取系统的pop 手势
        guard let sysetmGes = interactivePopGestureRecognizer else {return}
        
        //2. 获取手势添加到的view中
        guard let gestView = sysetmGes.view else { return }
        
        //3. 获取系统 target action
        //3.1 利用运行时机制 查看所有的属性名称
        // 系统没有把一个属性暴露给我们 而我们又想用它 就是通过截取
        
        /*
        var count:UInt32 = 0
        // 通过属性类型 遍历所有的属性名称 ivars保存的是所有属性的地址
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        
        for i in 0..<count{
        
            let ivar = ivars?[Int(i)]
            
            //1. 获取属性的名字
            let name = ivar_getName(ivar)
            
            //2. 将指针转换成字符串
            print(String(cString: name!))
        }
        */
        
        let targets = sysetmGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        print(targetObjc)
        
        // 取出target
        guard let tagert = targetObjc.value(forKey: "target") else{return}
        
        // 取出action
//        guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        
        let action = Selector(("handleNavigationTransition:"))
        
        // 创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gestView.addGestureRecognizer(panGes)
        panGes.addTarget(tagert, action: action)
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
