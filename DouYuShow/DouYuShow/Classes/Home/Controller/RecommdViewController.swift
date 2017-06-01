//
//  RecommdViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/1.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (kSCREENW - 3 * kItemMargin)/2
private let kItemH = kItemW*3/4
private let kNormalCellID =  "kNormalCellID"
private let kHeaderViewH : CGFloat = 50
private let kHeaderViewID = "kHeaderViewID"


class RecommdViewController: UIViewController {

    // mark:懒加载
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
    
        //1.先创建布局
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = CGSize(width:kItemW , height: kItemH)
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = kItemMargin
       layout.headerReferenceSize = CGSize(width:kSCREENW, height: kHeaderViewH)
       layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: 0)
    
       let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:kNormalCellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        // 这行的意思让 collectionView 的宽高随着父视图的改变而改变
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
    
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置ui
        setUpUI()
        
    }
}


// mark：设置UI
extension RecommdViewController{

    fileprivate func setUpUI(){
    
        view.addSubview(collectionView)
    }
}

// mark: 遵循collectionView datasourece
extension RecommdViewController:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
        
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.white
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1. 取出headview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = UIColor.green
        
        return headerView
    }

}



