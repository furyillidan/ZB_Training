//
//  HomeViewController.swift
//  Live_Training
//
//  Created by Neo on 2018/5/13.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTilteView = { [weak self] in
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
       let titles = ["推薦","遊戲","娛樂","趣玩"]
       let titleView = PageTilteView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        //確定pageContentView的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //確定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
    }

}


extension HomeViewController {
    private func setupUI() {
        //不需要調整UIScrollView的內邊距
        automaticallyAdjustsScrollViewInsets = false
        
        //設置導航欄
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    private func setupNavigationBar(){
    //用自訂uibutton才有按下去變圖的功能 所以此處不用uibarbutton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "history_home", hightImageName: "history_normal", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "search_home", hightImageName: "search_noraml", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "scan_home", hightImageName: "scan_normal", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

//遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTilteView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}
