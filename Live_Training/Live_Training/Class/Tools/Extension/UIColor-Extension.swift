//
//  UIColor-Extension.swift
//  Live_Training
//
//  Created by Neo on 2018/5/14.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
