//
//  RecommendViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class RecommendViewModel {

    
    
}



// mark: 发送网络请求
extension RecommendViewModel{


    func requestData(){
        
        //1. 请求第一部分推荐数据
        
        //2. 请求第二部分颜值数据
        
        //3. 请求第三部分的游戏数据
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://httpbin.org/get", parameters: nil, SuccessCallBack: { (reslut) in
            
            
        }) { (reslut) in
            
        }
    }



}
