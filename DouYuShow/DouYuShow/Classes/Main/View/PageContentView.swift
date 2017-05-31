//
//  PageContentView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class{
    func PageContenView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,TargetIndex:Int)
}

private let ContenCellID = "ContenCellID"

class PageContentView: UIView {

    // mark: 定义shuxing 
    fileprivate var childVCS:[UIViewController]
    fileprivate var StartOffset:CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    // 这里会造成循环引用 我用了weak 修饰 weak 只能修饰可选类型
    fileprivate weak var parentVC:UIViewController?
    
    // mark: 懒加载属性
    fileprivate lazy var colltionView:UICollectionView = { [weak self] in
    
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let colltionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colltionView.showsHorizontalScrollIndicator = false
        colltionView.isPagingEnabled = true
        colltionView.bounces = false
        colltionView.dataSource = self
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContenCellID)
        colltionView.delegate = self
        
        return colltionView
    }()
    
    init(frame: CGRect,childVCS:[UIViewController],parentViewController:UIViewController?) {
        
        self.childVCS = childVCS
        self.parentVC = parentViewController

        super.init(frame: frame)
        
        // 设置UI
        SetupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// mark:设置UI 界面
extension PageContentView{

    fileprivate func SetupUI(){
    
        //1.将所有的子试图控制起添加到父视图中
        for childVC in childVCS {
            parentVC?.addChildViewController(childVC)
        }
        
        //2.添加UICollectionView 用于在cell 中存放控制器的view
            addSubview(colltionView)
            colltionView.frame = bounds
    }
}

// mark: 遵守 colltionView  DataSource
extension PageContentView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colltionView.dequeueReusableCell(withReuseIdentifier: ContenCellID, for: indexPath)

        for view in cell.contentView.subviews{
        
            view.removeFromSuperview()
        }
        
        let childVC = childVCS[indexPath.row]
        cell.contentView.frame = childVC.view.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// mark: 遵守 colltionView  delegate 
extension PageContentView:UICollectionViewDelegate{

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
       StartOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.获取需要的数据
        var  progress:CGFloat = 0
        var  sourceIndex:Int = 0
        var  targetIndex:Int = 0
        
        //2. 判断左滑还是右滑
        let currentOffset = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffset>StartOffset{
            // 左滑
            progress = currentOffset/scrollViewW - floor(currentOffset/scrollViewW)
            sourceIndex = Int(currentOffset/scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVCS.count {
             
                targetIndex = childVCS.count
            }
            
            //如果完全滑过去
            if currentOffset - StartOffset == scrollViewW {
                
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            
            // 右滑
            progress = 1 - (currentOffset/scrollViewW - floor(currentOffset/scrollViewW))
            targetIndex = Int(currentOffset/scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCS.count{
            
                sourceIndex = childVCS.count - 1
            }
        
        }
        
        // 3. 将 progress／sourceIndex／targetIndex 传递给titleView
        delegate?.PageContenView(contentView: self, progress: progress, sourceIndex: sourceIndex, TargetIndex: targetIndex)
    }
}
//mark:对外暴漏的方法
extension PageContentView{

    func SetCurrentIndex(currentIndex:Int){
        
        // 滚动到
        UIView.animate(withDuration: 0.25) { 
            
            let offset = CGFloat(currentIndex) * self.colltionView.frame.width
            self.colltionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    
}
