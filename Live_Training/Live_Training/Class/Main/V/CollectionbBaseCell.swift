//
//  CollectionbBaseCell.swift
//  Live_Training
//
//  Created by Neo on 2018/5/23.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

class CollectionbBaseCell: UICollectionViewCell {
    
    
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    var anchor : AnchorModel? {
        didSet {
            
            //檢查模型是否有值
            guard let anchor = anchor else {return}
            
            //取出在線人數
            var onlineStr : String = ""
            if anchor.online >= 1000 {
                onlineStr = "\(Int(anchor.online / 10000))萬在線"
            }else{
                onlineStr = "\(anchor.online)在線"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
}
