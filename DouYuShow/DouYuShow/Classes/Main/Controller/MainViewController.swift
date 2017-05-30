//
//  MainViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AddChildVC(StoryName: "Home")
        AddChildVC(StoryName: "Live")
        AddChildVC(StoryName: "Flow")
        AddChildVC(StoryName: "Profile")
       
    }
    
    private func AddChildVC(StoryName:String){
    
        //1.通过storyBoard 获取控制器
        let childVC = UIStoryboard(name: StoryName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVC 作为子控制器
        addChildViewController(childVC)
    }
}
