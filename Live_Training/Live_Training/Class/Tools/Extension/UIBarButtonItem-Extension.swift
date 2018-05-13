//
//  UIBarButtonItem-Extension.swift
//  Live_Training
//
//  Created by Neo on 2018/5/13.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //這種寫法會是 一種類方法
    //UIBarButtonItem.createItem (imageName:String, hightImage:String, size: CGSize)
//    class func createItem (imageName:String, hightImage:String, size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: hightImage), for: .highlighted)
//
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//
//        return UIBarButtonItem(customView: btn)
//    }
    
    //便利構造函數: 1.convenience開頭 2.在構造函數中必須明確調用一個設計的構造函數
    //這種寫法會是
    //UIBarButtonItem(imageName:String, hightImage:String, size: CGSize)
    convenience init(imageName:String, hightImageName:String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        
            btn.setImage(UIImage(named: imageName), for: .normal)
        
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
            self.init(customView: btn)
    }
}
