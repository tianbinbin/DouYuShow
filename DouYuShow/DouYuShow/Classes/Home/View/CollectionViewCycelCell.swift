//
//  CollectionViewCycelCell.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/11.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycelCell: UICollectionViewCell {

    // 定义属性
    var cycleModel:CyceleModel?{
        
        didSet{
            
            titlelb.text = cycleModel?.title
            ImageV.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: cycleModel?.pic_url ?? "") as! URL))
        }
    }
    
    @IBOutlet weak var ImageV: UIImageView!
    @IBOutlet weak var titlelb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
