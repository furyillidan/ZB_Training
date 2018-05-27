//
//  GameViewController.swift
//  Live_Training
//
//  Created by Neo on 2018/5/27.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit


private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

class GameViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension GameViewController {
    
}
