//
//  WZHMainViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加所有子控制器
        addAllChildViewController()
    
    }


    
}

// MARK:- 添加所有子控制器
extension WZHMainViewController {
    
    func addAllChildViewController() {
        let vc0 = WZHChoicenessViewController()
        let sb = UIStoryboard(name: "WZHSearchViewController", bundle: nil)
        let vc1 = sb.instantiateInitialViewController()
        let vc2 = WZHActivityViewController()
        let vc3 = WZHMeViewController()
        
        setupChildView(vc0, title: "精选", image: UIImage(named: "tab_home_24x24_@3x")!, selImage: UIImage(named: "tab_home_active_24x24_@3x")!)
        setupChildView(vc1!, title: "探索", image: UIImage(named: "tab_explore_24x24_@3x")!, selImage: UIImage(named: "tab_explore_active_24x24_@3x")!)
        setupChildView(vc2, title: "活动", image: UIImage(named: "tab_event_24x24_@3x")!, selImage: UIImage(named: "tab_event_active_24x24_@3x")!)
        setupChildView(vc3, title: "我", image: UIImage(named: "tab_me_24x24_@3x")!, selImage: UIImage(named: "tab_me_active_24x24_@3x")!)
        
    }
}


// MARK:- 封装添加子控制器方法

extension WZHMainViewController {
    
    func setupChildView(viewController : UIViewController, title : String, image : UIImage, selImage : UIImage) {
        
        let vc = viewController
        let nav = UINavigationController(rootViewController: vc)
        nav.view.backgroundColor = UIColor(red: 233 / 255.0, green: 225 / 255.0, blue: 210 / 255.0, alpha: 1)
        addChildViewController(nav)
        vc.tabBarItem.title = title
        vc.tabBarController?.tabBar.tintColor = UIColor(red: 254 / 255.0, green: 103 / 255.0, blue: 55 / 255.0, alpha: 1)
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selImage
        
    
    }


}