//
//  CollectionPrettyCell.swift
//  Live_Training
//
//  Created by Neo on 2018/5/22.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit


class CollectionPrettyCell: CollectionbBaseCell {

   
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel?{
        didSet {
        
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        
        }
    }
}
