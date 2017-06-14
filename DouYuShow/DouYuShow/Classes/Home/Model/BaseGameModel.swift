//
//  BaseGameModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    var tag_name:String  = ""
    var icon_url :String  = ""
    
    // 自定义构造函数
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    // 因为字典 dict 可能由很多的key 我们需要的只需要这么多 所以要重写这个方法 不然会crash
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
    }
    
    // 再写一个构造函数
    override init() {
        
    }
    
}
