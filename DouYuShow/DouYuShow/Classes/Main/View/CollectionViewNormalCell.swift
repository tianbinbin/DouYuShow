//
//  CollectionViewNormalCell.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/6/2.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var iconImagev: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    

    // 定义属性
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
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickname.text = achor.nickname
            roomName.text = achor.room_name
            let iconurl = NSURL(string: achor.vertical_src)
            iconImagev.kf.setImage(with: ImageResource.init(downloadURL: iconurl as! URL))
        }
        
    
    }
    
    
    
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

}
