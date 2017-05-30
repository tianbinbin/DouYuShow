//
//  PageTitleView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    // mark: 定义属性
    fileprivate var titles : [String]
    
    // mark: 懒加载属性
    fileprivate lazy var titlelabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // mark: 滚动的线
    fileprivate lazy var ScrollLine:UIView = {
    
        let ScrollLine = UIView()
        ScrollLine.backgroundColor = UIColor.orange
        return ScrollLine
    }()
    
    
    
    // mark: 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        super.init(frame:frame)
        
        //1.设置UI界面
        SetUPUI()
        
    }
    
    // 重写 init 构造函数一定要实现这个方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageTitleView {

    fileprivate func SetUPUI(){
    
        // 1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加label
        SetUpTitleLabels()
        
        // 3.设置底线和滚动的滑块
        SetUpBootomlineAndScrollLine()
    }
    
    private func SetUpTitleLabels(){
    
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
        
            // 1.创建lb
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            
            titlelabels.append(label)
        }
    }

    private func SetUpBootomlineAndScrollLine(){
    
        //1.添加底线
        let bootomLine = UIView()
        bootomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bootomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bootomLine)
    
        //2.添加滚动的线
        //2.1 获取第一个lable
        guard let firstlabel = titlelabels.first else { return }
        firstlabel.textColor = UIColor.orange
        //2.2 设置ScrollLine的属性
        scrollView.addSubview(ScrollLine)
        ScrollLine.frame = CGRect(x: firstlabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstlabel.frame.width, height: kScrollLineH)
    }

}
