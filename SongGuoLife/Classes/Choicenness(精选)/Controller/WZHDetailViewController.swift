//
//  WZHDetailViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/26.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHDetailViewController: UIViewController {
// MARK:- 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navBackBtn: UIButton!
    @IBOutlet weak var navMarkBtn: UIButton!
    @IBOutlet weak var navShareBtn: UIButton!
    @IBOutlet weak var textScrollView: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- 监听按钮点击事件
extension WZHDetailViewController {
    
    //监听点击参加活动按钮
    @IBAction func joinBtn(sender: AnyObject) {
        
        
    }
    //监听点击导航栏返回按钮
    @IBAction func popViewController(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    //监听点击分享按钮
    @IBAction func shareBtnClick(sender: AnyObject) {
    }
    //监听点击标记按钮
    @IBAction func markBtnClick(sender: AnyObject) {
    }
   

}