//
//  RecommendCycleView.swift
//  Live_Training
//
//  Created by Neo on 2018/5/23.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            //設定pageControl個數
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默認滾動到中間某一位置 避免一開始用戶左滑 會空的
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定時器  先移除再新增避免產生問題
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
      super.awakeFromNib()
        //4.0預設該控件不受父控件的拉伸而拉伸
        //註冊cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //設置collectionview的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
    
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  * 10000來實現 無限連播  因為cell會重複利用 不會有效能問題
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
       // % cycleModels!.count 避免cycleModel[x] 中的x會超出界限
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.bounds.width * 0.5 滾動到一半pagecontrol就會顯示到下一頁
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //計算pageController的currentIndex
        //% (cycleModels?.count ?? 1) 來設定在無限連播時 pageControl會顯示正常當前頁面數
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    //用戶手動滑時 停止自動滾動功能
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    //用戶停止滑動時 開始自動滾動功能
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//對定時器的操作方法
extension RecommendCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate() //從運行循環中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        //獲取滾動的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //滾動到該位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}
