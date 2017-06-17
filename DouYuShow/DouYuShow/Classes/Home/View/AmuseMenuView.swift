//
//  AmuseMenuView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var groups:[AnchorGroup]?{
    
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        collectionView.register(UINib(nibName: "AmuseMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    // 设置布局在layoutsubview 设置
    override func layoutSubviews() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}


extension AmuseMenuView{

    class func AmuseMunuViewXib()->AmuseMenuView{
    
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if groups == nil {return 0}
        let pageNum = ((groups?.count)!-1)/8+1
        pageController.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuCollectionViewCell
        
        setupCellDataWithCell(cell: cell, index: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell:AmuseMenuCollectionViewCell,index:IndexPath){
    
        // 0 页 0 - 7
        // 1 页 8 - 15
        // 2 页 16 - 23
        
        //1.取出其实位置和终点位置
        let startindex = index.item * 8
        var endindex = (index.item+1)*8-1
        
        //2. 判断越界问题
        if endindex>(groups?.count)!-1{
            endindex = (groups?.count)!-1
        }
        
        //3.取出数据 摒弃赋值给cell
        cell.groups = Array(groups![startindex...endindex])
    }
    
}


