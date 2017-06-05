//
//  AnchorModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/5.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id :Int = 0                  //房间号
    var vertical_src :String = ""         //房间对应的urlstring
    var isVertical :Int = 0               //0 表示电脑直播 1 手机直播
    var room_name :String = ""            //房间名称
    var nickname :String = ""             //主播名称
    var online:Int = 0                    //在线人数
    
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    // 因为字典 dict 可能由很多的key 我们需要的只需要这么多 所以要重写这个方法 不然会crash
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
