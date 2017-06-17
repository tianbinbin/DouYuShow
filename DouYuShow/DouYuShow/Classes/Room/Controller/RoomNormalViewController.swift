//
//  RoomNormalViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = UIColor.gray
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // 隐藏导航栏 但必须还要手势
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // 这是系统的手势 设为true 依然能用
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // 隐藏导航栏 但必须还要手势
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}
