//
//  AnchorGroup.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

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

    var icon_name : String = "home_column_phoneGame"                 // 该组显示的图标
    var game_name :String = ""
    lazy var anchModelArr: [AnchorModel] = [AnchorModel]()           // 存储每一个模型中数组中的模型
    


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
