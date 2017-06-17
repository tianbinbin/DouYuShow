//
//  BaseViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/16.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class BaseViewModel {

    // 共同的信息
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel{

    // 这里 [String:Any]? 是一个可选类型可传可不传 [String:Any]? = nil 直接给一个默认值为nil
    // @escaping 当前闭包可能在其他地方使用到 作为逃逸的
    // post 请求

    func  loadAnchorData(urlStr:String,parameters:[String:Any]? = nil,finishedCallBack:@escaping()->()){
        
        NetWorkTools.RequestData(type: .GET, URLString: urlStr, parameters: parameters, SuccessCallBack: { (reslust) in
            
            // 1.对结果进行处理
            guard let reslutDict = reslust as? [String:Any] else{return}
            guard let dataArr = reslutDict["data"] as? [[String:Any]] else {return}
            
            // 2. 便利数组 将字典转换成模型
            for dict in dataArr {
                
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            // 3. 完成回调
            finishedCallBack()
        }) { (flaseresult) in
            
        }
    
    }

}
