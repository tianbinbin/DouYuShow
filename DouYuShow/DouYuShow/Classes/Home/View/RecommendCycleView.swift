
//
//  RecommendCycleView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/10.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"


class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagecontrollr: UIPageControl!
    
    var cycleModel:[CyceleModel]?{
    
        didSet{
            
            // 刷新colletionView
            collectionView.reloadData()
            
            // 设置 pagecontrollr 的个数
            pagecontrollr.numberOfPages = cycleModel?.count ?? 0
        
        }
    
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // 该控件不随着父空间的拉伸而拉伸
        collectionView.register(UINib(nibName: "CollectionViewCycelCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)

    }
    
    override func layoutSubviews() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

// 提供快速创建view的类方法
extension RecommendCycleView{

    class func RecommendCycleViewCustom()->RecommendCycleView{
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


// 遵守collectonView dataasource
extension RecommendCycleView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModel?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycelCell
        
        let cycleModelsingel = cycleModel?[indexPath.row]
        cell.cycleModel = cycleModelsingel
        
        return cell
    }
}

// 遵守collectonView Delegate
extension RecommendCycleView:UICollectionViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1. 获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2。计算pagecontroller  currentIndex
        pagecontrollr.currentPage = Int(offsetX/scrollView.bounds.width)
        
    }

}
