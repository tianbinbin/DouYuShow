//
//  UIColorExtenion.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

extension UIColor {

    // 便利构造函数: 1> convenience 开头 2> 在构造函数中必须明确调用一个设计的构造函数
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }


    class func randomColor()->UIColor{
    
        return UIColor(r: CGFloat(arc4random_uniform(256)), g:  CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)))
        
    }
}
