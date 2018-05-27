//
//  CycleModel.swift
//  Live_Training
//
//  Created by Neo on 2018/5/24.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

@objcMembers

class CycleModel: NSObject {

    var title : String = ""
    
    var pic_url : String = ""
    
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor : AnchorModel?
    
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
