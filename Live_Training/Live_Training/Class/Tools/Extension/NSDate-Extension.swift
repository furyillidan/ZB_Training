//
//  NSDate-Extension.swift
//  Live_Training
//
//  Created by Neo on 2018/5/20.
//  Copyright © 2018年 inow. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTimes() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
