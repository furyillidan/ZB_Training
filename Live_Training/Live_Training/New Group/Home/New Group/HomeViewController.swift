//
//  HomeViewController.swift
//  Live_Training
//
//  Created by Neo on 2018/5/13.
//  Copyright © 2018年 inow. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
    }

}


extension HomeViewController {
    private func setupUI() {
        //設置導航欄
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
    //用自訂uibutton才有按下去變圖的功能 所以此處不用uibarbutton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "history_home", hightImageName: "history_normal", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "search_home", hightImageName: "search_noraml", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "scan_home", hightImageName: "scan_normal", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

