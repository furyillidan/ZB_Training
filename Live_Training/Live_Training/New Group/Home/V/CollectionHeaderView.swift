//
//  CollectionHeaderView.swift
//  Live_Training
//
//  Created by Neo on 2018/5/18.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    //控件屬性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定義模型屬性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "Image_online")
        }
    }
    
}
