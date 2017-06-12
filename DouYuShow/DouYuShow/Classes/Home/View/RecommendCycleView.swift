
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
    
    var cycelTimer  : Timer?              // 定时器隔断时间滚动广告栏
    var cycleModel:[CyceleModel]?{
    
        didSet{
            
            // 刷新colletionView
            collectionView.reloadData()
            
            // 设置 pagecontrollr 的个数
            pagecontrollr.numberOfPages = cycleModel?.count ?? 0
            
            // 默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModel?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 先移除定时器 后添加
            RemoveCycleTimer()
            addCycelTime()
            

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
        return (cycleModel?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycelCell
        
        let cycleModelsingel = cycleModel?[indexPath.row % (cycleModel?.count)!]
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
        pagecontrollr.currentPage = Int(offsetX/scrollView.bounds.width) % (cycleModel?.count ?? 1)
    }
    
    // 用户拖拽的时候先移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        RemoveCycleTimer()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addCycelTime()
    }
}

// mark  定时器的操作方法
extension RecommendCycleView{
    
    fileprivate func addCycelTime(){
    
        cycelTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycelTimer!, forMode: .commonModes)
    }
    
    fileprivate func RemoveCycleTimer(){
    
        // 从运行中移除定时器
      cycelTimer?.invalidate()
      cycelTimer = nil
    }
    
    @objc private func scrollToNext(){
    
        // 1.获取滚动的偏移量
        let currOffset = collectionView.contentOffset.x
        let offset = currOffset + collectionView.bounds.width
        
       // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
        
    }

}
