//
//  CollectionCycleCell.swift
//  Live_Training
//
//  Created by Neo on 2018/5/25.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel?   {
        didSet {
            titleLabel.text = cycleModel?.title
            guard let iconURL = URL(string: (cycleModel?.pic_url)!) else {return}
//            let iconURL = URL(string: "https://staticlive.douyucdn.cn/storage/webpic_resources/upload/slide/2018/0509/201805091707279128.png")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}
