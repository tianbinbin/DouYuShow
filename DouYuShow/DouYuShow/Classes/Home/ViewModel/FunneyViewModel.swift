//
//  FunneyViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class FunneyViewModel {

    lazy var anChorArr:[AnchorModel] = [AnchorModel]()
}


extension FunneyViewModel{

    func loadFunnyData(finishedCallBack:@escaping()->()) {
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit":30,"offset":0], SuccessCallBack: { (reslut) in
            
            guard let reslutDict = reslut as? [String:Any] else{ return }
            guard let dataArr = reslutDict["data"] as? [[String:Any]] else{ return }
            
            
            for dict in dataArr{
                
                self.anChorArr.append(AnchorModel(dict: dict))
            }
            
            finishedCallBack()
            
        }) { (flasereslut) in
            
            
        }
    }
}

