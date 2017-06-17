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
private let kHeadViewh:CGFloat = 50
private let kHeadVieID = "CollectionHeaderReusableView"
private let kGameViewH:CGFloat = 90


class GameViewController: BaseViewController {

    // mark    懒加载属性
    fileprivate lazy var collectionView:UICollectionView = { [weak self] in
    
        //1. 创建布局
        let  layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        // 定义头的大小
        layout.headerReferenceSize = CGSize(width: kSCREENW, height: kHeadViewh)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadVieID)
        // collectionView 随着父视图的拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionView
    }()
    
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    
    fileprivate lazy var topHeadView:CollectionHeaderReusableView = {
    
        let topHeadView = CollectionHeaderReusableView.colltionHeadViewCustom()
        topHeadView.frame = CGRect(x: 0, y: -kHeadViewh-kGameViewH, width: kSCREENW, height: kHeadViewh)
        topHeadView.moreBtn.isHidden = true
        topHeadView.titlelabel.text = "常用"
        topHeadView.IconImageV.image = UIImage(named: "home_header_hot")
        return topHeadView
    }()
    
    fileprivate lazy var gameView:RecommendGameView = {
        
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kSCREENW, height: kGameViewH)
        return gameView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetupUI()
        
        //2. 请求数据
        loadData()
        
        
    }
}

extension GameViewController{

    override func SetupUI(){
        
        super.SetupUI()
    

        //1. 添加 collectionView
        view.addSubview(collectionView)
        
        //2. 添加 topHeadView
        collectionView.addSubview(topHeadView)
        
        //3. 添加常用gameview
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kHeadViewh+kGameViewH, left: 0, bottom: 0, right: 0)
        
        collectionView.isHidden = true
    }
}

extension GameViewController:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadVieID, for: indexPath) as! CollectionHeaderReusableView
        headView.titlelabel.text = "全部"
        headView.IconImageV.image = UIImage(named: "columnHotIcon")
        headView.moreBtn.isHidden = true
        return headView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        let ganmeModel = gameVM.gameModel[indexPath.row]
        
        cell.base = ganmeModel
        
        return cell
    }
}

// 请求数据
extension GameViewController{

   fileprivate func loadData(){
    
    gameVM.LoadallGameDat {
        self.collectionView.isHidden = false
        //1.展示常用信息
        self.collectionView.reloadData()
        
        //2.展示常用游戏
        /*
        var tempaArray = [BaseGameModel]()
        for i in 0..<10{
            // 获取前十条数据
            tempaArray.append(self.gameVM.gameModel[i])
        }
        
        */
        
        // 同一个区间在一个数组中取出。然后转换成另外一个数组 Array(tempArr)
        let tempArr = self.gameVM.gameModel[0..<10]
        
        self.gameView.goups = Array(tempArr)
    }
    }
}
