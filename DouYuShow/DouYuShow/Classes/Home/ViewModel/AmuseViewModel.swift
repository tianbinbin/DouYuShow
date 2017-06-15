//
//  AmuseViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/15.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class AmuseViewModel{
    
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()

}

extension AmuseViewModel{

    func loadAmuseData(finisedCallBack:@escaping ()->()){
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil, SuccessCallBack: { (reslust) in
            
            // 1.对结果进行处理
            guard let reslutDict = reslust as? [String:Any] else{return}
            guard let dataArr = reslutDict["data"] as? [[String:Any]] else {return}

            // 2. 便利数组 将字典转换成模型
            for dict in dataArr {
        
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            // 3. 完成回调
            finisedCallBack()
        }) { (flaseresult) in
            
        }
    }
}
