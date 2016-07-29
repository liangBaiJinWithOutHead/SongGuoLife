//
//  WZHLaunchViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/11.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHLaunchViewController: UIViewController {
    
    //定义属性
    var timer : NSTimer? = nil
    
    //控件属性
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加全部动画
        addAllAnimate()
        
        //创建一个定时器控制界面跳转
        timer = NSTimer.scheduledTimerWithTimeInterval(topImageView.animationDuration + 1.3, target: self, selector: #selector(WZHLaunchViewController.turnViewController), userInfo: nil, repeats: true)
        
    }
    
}

// MARK:- 添加顶部位置帧动画
extension WZHLaunchViewController {
    
    func addAllAnimate() {
    
        var images = [UIImage]()
       
        for i in 0...28 {
            
            let str = String(format: "launchA%02d_172x240_@1x", i)
            let image = UIImage(named: str)
            images.append(image!)
        }
            topImageView.animationImages = images
        
        topImageView.animationRepeatCount = 1
        topImageView.image = UIImage(named: "launchA28_172x240_@1x")
        topImageView.animationDuration = 1.0
        topImageView.startAnimating()

        performSelector(#selector(WZHLaunchViewController.addMidBotAnimate), withObject: nil, afterDelay: topImageView.animationDuration * 0.6)
    }

}

// MARK:- 添加中间和底部位置动画
extension WZHLaunchViewController {
    
    func addMidBotAnimate() {
        
        middleImageView.image = UIImage(named: "launch_title_39x18_@3x")
        middleImageView.alpha = 0
        UIView.animateWithDuration(0.5) {
            self.middleImageView.alpha = 1
        }
        
        bottomImageView.image = UIImage(named: "launch_slogan_83x14_@3x")
        bottomImageView.alpha = 0
        UIView.animateWithDuration(0.5) {
            self.bottomImageView.alpha = 1
        }
        
    }

}

// MARK:- 计时器控制完成跳转窗口
extension WZHLaunchViewController {
    
    func turnViewController() {

        UIApplication.sharedApplication().keyWindow?.rootViewController = WZHMainViewController()
        timer?.invalidate()
    }

}






