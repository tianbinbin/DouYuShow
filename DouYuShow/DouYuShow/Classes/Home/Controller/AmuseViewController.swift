//
//  AmuseViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/15.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (kSCREENW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW*4/5
private let kPretyItemH = kItemW*5/4
private let kNormalCellID =  "kNormalCellID"
private let kPretyCellID =  "kPretyCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kHeaderViewH : CGFloat = 50
private let kAmuseMenuViewH :CGFloat = 200

class AmuseViewController: BaseViewController {

    // colltionView
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        
        //1.先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:kItemW , height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width:kSCREENW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPretyCell", bundle: nil), forCellWithReuseIdentifier: kPretyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.backgroundColor = UIColor.white
        // 这行的意思让 collectionView 的宽高随着父视图的改变而改变
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    
        return collectionView
    }()
    
    // viewModel 
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel()
    
    // amusuMenuView
    fileprivate lazy var amuseMenuView: AmuseMenuView = {
    
        let amuseMenuView = AmuseMenuView.AmuseMunuViewXib()
        amuseMenuView.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kSCREENW, height: kSCREENW)

        return amuseMenuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置ui
        setupUI()
        
        // 2.请求数据
        loadData()
        
        
    }
}

// 设置ui
extension AmuseViewController {
    fileprivate func setupUI(){
    
        //1. 添加collectionView
        view.addSubview(collectionView)
        
        //2. 添加amuseMenuView
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0 )
        
        collectionView.isHidden = true
    }
}

// 请求数据
extension AmuseViewController{

    fileprivate func loadData(){
    
        amuseVM.loadAmuseData { 
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            self.amuseMenuView.groups = self.amuseVM.anchorGroups
        }
    }
}

// mark: 遵循collectionView datasourece
extension AmuseViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return amuseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return amuseVM.anchorGroups[section].anchModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let  cell = (collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)) as!CollectionViewNormalCell
        
        cell.achor = amuseVM.anchorGroups[indexPath.section].anchModelArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1. 取出headview
        let headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderReusableView
        
        // 2.给headvieww 设置数据
        headview.group = amuseVM.anchorGroups[indexPath.section]
        
        return headview
    }
}
