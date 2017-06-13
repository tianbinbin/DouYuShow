//
//  GameViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/13.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
private let kEdgeMargin:CGFloat = 10
private let kItemW:CGFloat = (kSCREENW - 2 * kEdgeMargin)/3
private let kItemH:CGFloat = kItemW*6/5
private let kGameCellID = "kGameCellID"



class GameViewController: UIViewController {

    // mark    懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [weak self] in
    
        //1. 创建布局
        let  layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUPUI()
        
    }
}

extension GameViewController{

    fileprivate func SetUPUI(){
    
        //1. 添加 collectionView
        view.addSubview(collectionView)
    }
}

extension GameViewController:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()

        return cell
    }

}
