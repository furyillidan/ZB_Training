//
//  PageContentView.swift
//  Live_Training
//
//  Created by Neo on 2018/5/14.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    private var childVcs : [UIViewController]
    //避免循環引用
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    //避免閉包循環引用
    private lazy var collectionView : UICollectionView = {[weak self] in
        //設定layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)! 
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //創建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        //監控collectionview的滾動狀態
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    //自定義構造函數
    init(frame: CGRect, childVcs : [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// 設置UI介面
extension PageContentView {
    private func setupUI() {
        //將所有子控制器添加到父控制器裡
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        //添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//讓PageContentView 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //給cell設定內容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }  //避免cell過多  有循環利用cell 先移除後面再添加
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension PageContentView: UICollectionViewDelegate {
    //獲取左滑又滑時偏移的量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    //監控collectionview 滾動
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //定義獲取需要的數據
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判斷左滑還是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollView = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            progress = currentOffsetX / scrollView - floor(currentOffsetX / scrollView)
            sourceIndex = Int(currentOffsetX / scrollView)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //如果全滑過去
            if currentOffsetX - startOffsetX == scrollView {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            progress = 1 - (currentOffsetX / scrollView - floor(currentOffsetX / scrollView))
            
            targetIndex = Int(currentOffsetX / scrollView)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //將progress/sourceIndex/targetIndex傳遞給titleview
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        print("progress:\(progress) , sourceIndex:\(sourceIndex) , targetIndex:\(targetIndex) ")
        
    }
}

//對外暴露的方法
extension PageContentView {
    func setCurrentIndex (currentIndex: Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
