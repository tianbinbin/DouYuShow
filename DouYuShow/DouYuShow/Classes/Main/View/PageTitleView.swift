//
//  PageTitleView.swift
//  DouYuShow
//
//  Created by 田彬彬 on 2017/5/30.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

//协议代理
protocol PageTitleViewDelegate:class{
 
    // selectindex index  selectindex 作为外部参数 index 作为内部参数
    func pageTitle(titleView:PageTitleView,selectindex index:Int)
}

class PageTitleView: UIView {

    // mark: 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex:Int = 0
    weak var delegate : PageTitleViewDelegate?
    
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
            
            // 2.给lb添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titltLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
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

extension PageTitleView{

    @objc fileprivate func titltLabelClick(_ tapGes:UITapGestureRecognizer){
        
        //1. 获取当前label 的 下标值
        guard let currentlb = tapGes.view as? UILabel else { return }
        
        //2. 获取之前的lb
        let olderLabel = titlelabels[currentIndex]
        
        //3. 保存最新lb的下标值
        currentIndex = currentlb.tag
    
        //4. 切换文字的颜色
        currentlb.textColor = UIColor.orange
        olderLabel.textColor = UIColor.darkGray
        
        //5. 滚动条的位置发生改变
        let scrollLinePosition = CGFloat(currentlb.tag) * ScrollLine.frame.width
        
        UIView.animate(withDuration: 0.25) {
            
           self.ScrollLine.frame.origin.x = scrollLinePosition
        }
        
        //6.通知代理
        delegate?.pageTitle(titleView: self, selectindex: currentIndex)
    }
}

