//
//  AnchorGroup.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var room_list : [[String:Any]]? {                           // 该组中对应的房间信息
    
        didSet{
          
            guard  let room_list = room_list else {
                
                return
            }
            
            for dictsubs in room_list{
                
                let anchModel = AnchorModel(dict: dictsubs)
                self.anchModelArr.append(anchModel)
            }
        }
    }
    var tag_name : String = ""                                       // 改组显示的标题
    var icon_name : String = "home_column_phoneGame"                 // 该组显示的图标
    var icon_url:String = ""
    var game_name :String = ""
    lazy var anchModelArr: [AnchorModel] = [AnchorModel]()           // 存储每一个模型中数组中的模型
    
    // 重写构造函数
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    // 再写一个构造函数
    override init() {
        
    }
    
    
    // 因为字典 dict 可能由很多的key 我们需要的只需要这么多 所以要重写这个方法 不然会crash
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "room_list" {
        
            guard let anchModel = value as? [[String:Any]] else { return }
            
            for dictsubs in anchModel{
            
              let anchModel = AnchorModel(dict: dictsubs)
              self.anchModelArr.append(anchModel)
            }
        }
        
        if key == "tag_name"{
        
            guard let anchModel = value as? [[String:Any]] else { return }
    
            
        }
        
        
    }
}
