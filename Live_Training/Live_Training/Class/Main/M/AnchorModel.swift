//
//  AnchorModel.swift
//  Live_Training
//
//  Created by Neo on 2018/5/21.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit
@objcMembers
class AnchorModel: NSObject {
    //房間 ID
    var room_id : Int = 0
    //房間圖片對應的URLString
    var vertical_src : String = ""
    //判斷是手機還是電腦直播
    //0:電腦直播  1:手機直播
    var isVertical : Int = 0
    //房間名稱
    var room_name : String = ""
    //主播暱稱
    var nickname : String = ""
    //觀看人數
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
