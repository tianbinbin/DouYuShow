//
//  AmuseMenuCollectionViewCell.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/17.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnchorGroup]?{
    
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        
    }

    override func layoutSubviews() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
    
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension AmuseMenuCollectionViewCell:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        cell.base = groups![indexPath.item]
        
        return cell
    }
}
