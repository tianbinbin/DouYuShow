//
//  RecommendViewModel.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/5.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
       // 懒加载一个数组 存放 解析过后的模型
       lazy var anChorArr:[AnchorGroup] = [AnchorGroup]()
    
       fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
       fileprivate lazy var pretyGroup: AnchorGroup = AnchorGroup()

}


// 发送网络请求
extension RecommendViewModel{

    func requestData(finishedCallBack:@escaping ()->()){
        
        //0.的定义参数
         let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime() as NSString]
        
        
        // 创建线程的组
        let gcdgroup = DispatchGroup()
        
        gcdgroup.enter()
        //1. 请求第一部分推荐数据
        //  http://capi.douyucdn.cn/api/v1/getbigDataRoom
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime() as NSString], SuccessCallBack: { (reslut) in
            
            guard let reslutDict = reslut as? [String:Any] else{ return }
            guard let dataArr = reslutDict["data"] as? [[String:Any]] else{ return }
            
            // 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArr{
                
                let Model = AnchorModel(dict:dict)
                self.bigDataGroup.anchModelArr.append(Model)
            }
            
            gcdgroup.leave()
            print("第一部分请求完成")
            
        }) { (reslut) in
            
        }
        
        gcdgroup.enter()
        //2. 请求第二部分颜值数据
        //  http://capi.douyucdn.cn/api/v1/getVerticalRoom
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, SuccessCallBack: { (reslut) in
            
            guard let reslutDict = reslut as? [String:Any] else{ return }
            guard let dataArr = reslutDict["data"] as? [[String:Any]] else{ return }
            
            // 设置组的属性
            self.pretyGroup.tag_name = "颜值"
            self.pretyGroup.icon_name = "home_header_phone"
            
            for dict in dataArr{
            
                let Model = AnchorModel(dict:dict)
                self.pretyGroup.anchModelArr.append(Model)
            }
            gcdgroup.leave()
            print("第二部分请求完成")
        }) { (reslut) in
            
        }
        
        gcdgroup.enter()
        //3. 请求第三部分的游戏数据
        //  http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1496581342
        //   print(NSDate.getCurrentTime())
        
        NetWorkTools.RequestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters, SuccessCallBack: { (reslut) in
            
            // 将 reslut 由 (Anyobject) 类型 转换成 [String:NSObject] 字典类型
            guard let reslutDict = reslut as? [String:Any] else {

                print("reslut先由(Anyobject) 类型 转换成 [String:NSObject]? 如果转换成功那么 reslut 将变成 [String:NSObject]? 类型 ,然后通过guard 可选绑定 由[String:NSObject]? 类型转换成 [String:NSObject] 如果转换成功 那么 reslutDict 就是[String:NSObject] 类型 如果转换失败 那么就会输出这段文字")
                
                 return
                }
            
            /*
             let data = reslutDict["data"]
             let dataArray =  data as? [[String:NSObject]]
             
             reslutDict 是一个 [String:NSObject] 类型 字典中取出可能取出NSObject 也可能取出nil
             所以  data  是一个 NSObject？
             然后  将 data 通过 as？ 转换成一个数组的可选类型[]? 这个数组[]? 里面存储的是一个 [String:NSObject] 字典类型
             所以 dataArray 的类型就是一个 [[String:NSObject]]？ 类型
             
             
             // 这一步是通过可选绑定 将 reslutDict["data"] as? [[String:NSObject]] 由原来的 [[String:NSObject]] ？ 转换成[[String:NSObject]] 类型
             guard  let dataArray =  reslutDict["data"] as? [[String:NSObject]] else { return }
             
             */
            
            guard let dataArray =  reslutDict["data"] as? [[String:Any]] else { return }
            
            // 遍历 dataArray 使用kvc的形式将字典 转换成模型对象
             for dict in dataArray{
                
                 let group = AnchorGroup(dict:dict)
                 self.anChorArr.append(group)
            }
            /*
            for model in self.anChorArr{
            
                for dicst in model.anchModelArr{
                
                    print(dicst.nickname)
                }
            }
            */
            
            gcdgroup.leave()
            print("第三部分请求完成")
            
            }) { (reslut) in
                                        
                print(reslut)
            }
        
        
        //4.所有数据已请求完成 然后进行排序数据
        gcdgroup.notify(queue: DispatchQueue.main) {
         
            print("所有的数据都请求完成")
            
            self.anChorArr.insert(self.pretyGroup, at: 0)
            self.anChorArr.insert(self.bigDataGroup, at: 0)
            
            // 经过上面的这两部。self.anChorArr 数据排序就是 1. self.bigDataGroup 2. self.pretyGroup  3.最后的数据
            
            finishedCallBack()
        }
    }
    
}
