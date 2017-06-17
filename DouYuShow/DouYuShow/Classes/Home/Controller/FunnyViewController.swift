//
//  FunnyViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit


private let kItemMargin:CGFloat = 10
private let kItemW = (kSCREENW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW*4/5
private let kPretyItemH = kItemW*5/4
private let kNormalCellID =  "kNormalCellID"
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH = kSCREENW * 3/8
private let kGameViewH = CGFloat(90.0)

class FunnyViewController: BaseViewController {

    // mark:懒加载
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        
        //1.先创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:kItemW , height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.backgroundColor = UIColor.white
        // 这行的意思让 collectionView 的宽高随着父视图的改变而改变
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
        
        }()
    
    
    fileprivate var funnyVM:FunneyViewModel = FunneyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        LoadData()
        
        
    }

}


// mark：设置UI
extension FunnyViewController{
    
    fileprivate func setUpUI(){
        
        view.addSubview(collectionView)
        
        collectionView.isHidden = true
    }
}

extension FunnyViewController{

    fileprivate func LoadData(){
    
        funnyVM.loadFunnyData { 
            
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
}


// mark: 遵循collectionView datasourece
extension FunnyViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return funnyVM.anChorArr.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as!CollectionViewNormalCell
        
        cell.achor = self.funnyVM.anChorArr[indexPath.item]
        
        return cell
    }
}
