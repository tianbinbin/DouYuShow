//
//  GameViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class GameViewModel:BaseViewModel {
    

    lazy var gameModel:[GameModel] = [GameModel]()

}

extension GameViewModel{

    func LoadallGameDat(finisuhedCallBack:@escaping ()->()){
        
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"], SuccessCallBack: { (reslut) in
            
            // 1。获取得到的shuju
            guard let reslutDic = reslut as? [String:Any] else{return}
            
            guard let dataArray = reslutDic["data"] as? [[String:Any]] else {return}
            
            for dic in dataArray{
            
             self.gameModel.append(GameModel(dict: dic))
            
            }
            
            // 完成回调
            finisuhedCallBack()
            
        }) { (fail) in
            
        }
 
        
        //loadAnchorData(urlStr: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"], finishedCallBack: finisuhedCallBack)

    }
    
}
