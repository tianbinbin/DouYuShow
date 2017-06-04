//
//  NSDateExtention.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import Foundation

extension NSDate{

    class func getCurrentTime()->String{
    
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
