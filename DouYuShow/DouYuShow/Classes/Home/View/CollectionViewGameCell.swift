//
//  CollectionViewGameCell.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/13.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewGameCell: UICollectionViewCell {

    
    //mark ----- 定义模型
    @IBOutlet weak var iconimagev: UIImageView!          // 图片
    @IBOutlet weak var titlelb: UILabel!
    
    var group : AnchorGroup?{
    
        didSet{
        
          titlelb.text = group?.tag_name ?? ""
          iconimagev.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: group?.icon_name ?? "") as! URL))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
