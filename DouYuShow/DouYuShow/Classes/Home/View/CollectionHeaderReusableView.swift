//
//  CollectionHeaderReusableView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/2.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {

    // 控件属性
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var IconImageV: UIImageView!
    
    var group:AnchorGroup?{
    
        didSet{
        
            titlelabel.text = group?.tag_name
            IconImageV.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            
        }
    
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
