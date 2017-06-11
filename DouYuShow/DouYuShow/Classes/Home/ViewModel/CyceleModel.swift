//
//  CyceleModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/11.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class CyceleModel: NSObject {

    var title:String = ""                           // 标题
    var pic_url :String = ""                        // 图片
    var room:[String:Any]?{                         // 主播对应的信息
    
        didSet{
        
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor:AnchorModel?                         // 主播信息model
    
    // 自定义构造函数
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
    
}
