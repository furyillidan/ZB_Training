//
//  CollectionGameCell.swift
//  Live_Training
//
//  Created by Neo on 2018/5/27.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let iconURL = URL(string: group?.icon_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
}
