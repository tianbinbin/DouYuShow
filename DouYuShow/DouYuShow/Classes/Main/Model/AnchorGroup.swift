//
//  AnchorGroup.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var room_list : [String:NSObject]?                                 // 该组中对应的房间信息
    var tag_name : String = ""                                       // 改组显示的标题
    var icon_name : String = "home_column_phoneGame"                 // 该组显示的图标
    
    // 重写构造函数
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    // 因为字典 dict 可能由很多的key 我们需要的只需要这么多 所以要重写这个方法 不然会crash
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
