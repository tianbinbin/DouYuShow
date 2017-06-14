//
//  RecommendGameView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/12.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {

    // mark------ colltionView
    @IBOutlet weak var colletionView: UICollectionView!
    
    var goups:[AnchorGroup]?{
    
        didSet{
            
            goups?.removeFirst()
            goups?.removeFirst()
            
            // 添加更多组
            let moregroup = AnchorGroup()
            moregroup.tag_name = "更多"
            goups?.append(moregroup)
            
            colletionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        
        // 移除atuoresizing 让控件不随着父控件的拉伸而拉伸
        autoresizesSubviews = false
        
        // 注册cell
        colletionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
}

// 提供快速创建的类方法
extension RecommendGameView{

    class func recommendGameView() ->RecommendGameView{
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }

}

// nark-----遵守colletionView 的数据协议
extension RecommendGameView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goups?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        cell.base = goups![indexPath.item]
    
        return cell
    }
}

