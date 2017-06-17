//
//  BaseViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    fileprivate  lazy var animimageV:UIImageView  = { [weak self] in
        
        let animimageV = UIImageView(image: UIImage(named: "dyla_img_loading_1"))
        
        animimageV.center = (self?.view.center)!
        // 数组中不允许存放可选类型
        animimageV.animationImages = [UIImage(named: "dyla_img_loading_1")!,UIImage(named: "dyla_img_loading_2")!,UIImage(named: "dyla_img_loading_3")!,UIImage(named: "dyla_img_loading_4")!]
        animimageV.animationDuration = 0.5
        animimageV.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        //LONG_MAX 表示非常大的值
        animimageV.animationRepeatCount = LONG_MAX
        return animimageV
    
    }()
    
    // mark   系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        SetupUI()
  
    }
}

extension BaseViewController{
    
    func SetupUI() {
        
        // 添加执行动画的 UIImageView
        view.addSubview(animimageV)
        animimageV.startAnimating()
    }
}
