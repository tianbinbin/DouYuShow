//
//  UIbBarButtonItemExtension.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 类方法的扩充
    class func CreateItem(imageName:String,hightImageName:String,Size:CGSize)->UIBarButtonItem{
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: Size)
        return UIBarButtonItem(customView: btn)
    }
    
    
    // swift 推荐我们使用构造函数
    // 便利构造函数: 1> convenience 开头 2> 在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName:String,hightImageName:String = "",Size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if hightImageName != ""{
        
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        
        if Size == CGSize.zero{
        
            btn.sizeToFit()
        }else{
        
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: Size)
        }
    
        self.init(customView: btn)
    }
    
}
