//
//  RecommendViewModel.swift
//  Live_Training
//
//  Created by Neo on 2018/5/20.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//發送網路請求
extension RecommendViewModel {
    func requestData(finishCallback : @escaping () -> ()) {
        //定義參數
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTimes()]
        
        //創建Group
        let dGroup = DispatchGroup()
        //發送請求後進入
        dGroup.enter()
        //請求推薦數據
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTimes()]) { (result) in
            
            //將result轉成字典類型
            guard let resultDict = result as? [String : NSObject] else {return}
            //根據data的key 獲取數組
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //遍歷數組 獲取字典 並將字典轉成模型對象
           
            //設置組的屬性
            self.bigDataGroup.tag_name = "熱門"
            self.bigDataGroup.icon_name = "home_Header_Hot"
            
            //獲取主播數據
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //請求後有數據在離開組
            dGroup.leave()
            print("請求到熱門數據")
        }
        
        dGroup.enter()
        //請求顏值數據
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //將result轉成字典類型
            guard let resultDict = result as? [String : NSObject] else {return}
            //根據data的key 獲取數組
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //遍歷數組 獲取字典 並將字典轉成模型對象
        
            //設置組的屬性
            self.prettyGroup.tag_name = "顏值"
            self.prettyGroup.icon_name = "home_Header_Phone"
            
            //獲取主播數據
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
            print("請求到顏值數據")
        }
        
        //請求遊戲數據
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1526808262
        dGroup.enter()
        print("現在時間",NSDate.getCurrentTimes())
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //將result轉成字典類型
            guard let resultDict = result as? [String : NSObject] else {return}
            //根據data的key 獲取數組
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //遍歷數組 獲取字典 並將字典轉成模型對象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
        }
//            for group in self.anchorGroups {
//                for anchor in group.anchors {
//                   // print(anchor.nickname)
//                }
//            }
            dGroup.leave()
            print("請求到遊戲數據")
      }
        //所有的數據都請求到,之後開始排序
        dGroup.notify(queue: .main) {
            print("所有數據都請求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
   }
    
}
