//
//  RecommendGameView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

    override func awakeFromNib() {
        
        // 移除atuoresizing 让控件不随着父控件的拉伸而拉伸
        autoresizesSubviews = false
        
    }
}


// 提供快速创建的类方法
extension RecommendGameView{

    class func recommendGameView() ->RecommendGameView{
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }

}
