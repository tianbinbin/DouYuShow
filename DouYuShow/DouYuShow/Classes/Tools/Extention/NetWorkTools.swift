//
//  NetWorkTools.swift
//  AlamofireDemp
//
//  Created by 田彬彬 on 2017/6/4.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
import Alamofire

// 定义请求方式
enum MethodType{

    case GET
    case POST
    
}


class NetWorkTools {

    class func RequestData(type:MethodType,URLString:String,parameters:[String:NSString]? = nil,SuccessCallBack:@escaping(_ Success:AnyObject)->(),FalseCallBack:@escaping (_ false:AnyObject)->()){
    
        //1. 获取类型
        let method = type == .GET ? HTTPMethod.get: HTTPMethod.post
        
        // post 请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result =  response.result.value else{
                
                // 请求失败
                FalseCallBack(response.result.error as AnyObject)
                
                return
            }
            
           // 请求成功
            SuccessCallBack(result as AnyObject)
            
        }
        
    }
    
}
