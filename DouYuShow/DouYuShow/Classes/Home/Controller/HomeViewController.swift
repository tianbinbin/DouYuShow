//
//  HomeViewController.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40


class HomeViewController: UIViewController {
    
    // 懒加载TitleView
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
    
    let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavgationBarH, width: kSCREENW, height: kTitleViewH)
    let titles = ["推荐","游戏","娱乐","趣玩"]
    let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
    return titleView

    }()
    
    // 懒加载PageContentView
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contenHight = kSCREENH - (kStatusBarH+kNavgationBarH+kTitleViewH+kTabBarH)
        let contentframe = CGRect(x: 0, y: kStatusBarH+kNavgationBarH+kTitleViewH, width: kSCREENW, height: contenHight)
        
        //2. 确定控制器
        var childVCS = [UIViewController]()
        childVCS.append(RecommdViewController())
        childVCS.append(GameViewController())
        childVCS.append(AmuseViewController())
        childVCS.append(FunnyViewController())

        let pageContentView = PageContentView(frame: contentframe, childVCS: childVCS, parentViewController: self)
            pageContentView.delegate = self
    
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置UI界面
        setupUI()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.orange
    }

}

// Mark-- 设置UI
extension HomeViewController{

    fileprivate func setupUI(){
    
        // 1.设置导航栏
        SetupNavgationBar()
    
    }
    
    private func SetupNavgationBar(){
    
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "dym_browser_nav_loading"), for: .default)
        
        // 1. 设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
        // 2. 设置右侧item
        let size = CGSize(width: 30, height: 30)

        /*  这种是通过类的扩展的封装
        let historyItem = UIBarButtonItem.CreateItem(imageName: "viewHistoryIcon", hightImageName: "viewHistoryIconHL", Size: size)
        let gameItem = UIBarButtonItem.CreateItem(imageName: "home_newGameicon", hightImageName: "home_newGameicon", Size: size)
        */
        
        // 这种是重写写了一个构造函数
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", hightImageName: "viewHistoryIcon", Size: size)
        let gameItem = UIBarButtonItem(imageName: "home_newGameicon", hightImageName: "home_newGameicon", Size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,gameItem]
        
    }

}


//mark:遵守PageTitleViewdelegate
extension HomeViewController:PageTitleViewDelegate{

    func pageTitle(titleView: PageTitleView, selectindex index: Int) {
        
        pageContentView.SetCurrentIndex(currentIndex: index)
    }
}

//mark:遵守PageContentViewdelegate
extension HomeViewController:PageContentViewDelegate{

    func PageContenView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, TargetIndex: Int) {
        pageTitleView.SetTitleViewProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: TargetIndex)
    }
}




