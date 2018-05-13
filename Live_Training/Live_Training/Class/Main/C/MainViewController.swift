//
//  MainViewController.swift
//  Live_Training
//
//  Created by Neo on 2018/5/13.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
    }

    
    private func addChildVc(storyName: String) {
        
        let chidVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        
        addChildViewController(chidVc!)
        
    }
    
}
