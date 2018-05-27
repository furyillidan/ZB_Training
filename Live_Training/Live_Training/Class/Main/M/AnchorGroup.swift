//
//  AnchorGroup.swift
//  Live_Training
//
//  Created by Neo on 2018/5/20.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit
@objcMembers
//在swift3中，會自動推斷@objc，會自動添加@objc
//在swift4中，不會自動推斷，要在每個element前加@objc
//簡單方法 @objcMembers
//       class Test {   }
class AnchorGroup: NSObject {
    //該組中對應的房間信息
    var room_list : [[String:NSObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    //組顯示的標題
    var tag_name : String = ""
    //組顯示的圖標
    var icon_name : String = "Image_online"
    //遊戲對應的圖標
    var icon_url : String = ""
    //定義主播的模型對象數組
    var anchors : [AnchorModel] = [AnchorModel]()
    
    //構造函數
    override init() {
    }
    
    //將字典轉成model
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String : NSObject]] {
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }
}



