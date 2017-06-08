//
//  CollectionViewPretyCell.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/3.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPretyCell: UICollectionViewCell {

    @IBOutlet weak var onlinBtn: UIButton!
    @IBOutlet weak var iconImagev: UIImageView!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nicknamelb: UILabel!
    
    var achor :AnchorModel?{

        didSet{
        
            guard let achor = achor else {
                return
            }
            // 1.取出在线人数显示的文字
            var onlineStr:String = ""
            
            if achor.online >= 10000{
            
                onlineStr = "\(Int(achor.online/10000))万在线"
            }else{
            
                onlineStr = "\(achor.online)在线"
            }
            
            onlinBtn.setTitle(onlineStr, for: .normal)
            nicknamelb.text = achor.nickname
            cityBtn.setTitle(achor.anchor_city, for: .normal)
            let iconurl = NSURL(string: achor.vertical_src)
            iconImagev.kf.setImage(with: ImageResource.init(downloadURL: iconurl as! URL))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
