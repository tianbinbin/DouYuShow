//
//  PageContentView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let ContenCellID = "ContenCellID"

class PageContentView: UIView {

    // mark: 定义shuxing 
    fileprivate var childVCS:[UIViewController]
    
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

// mark: 遵守 colltionView 协议
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
