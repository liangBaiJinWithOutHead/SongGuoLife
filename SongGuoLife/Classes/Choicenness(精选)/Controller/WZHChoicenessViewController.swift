//
//  WZHChoicenessViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import MJExtension
import MJRefresh

private let ID = "Choice"
class WZHChoicenessViewController: WZHBaseViewController {
    //保存navigationbar透明度,下次切换回来视图直接设置
    private var alphaValue : CGFloat?
    private var datas : [WZHChoicennessItem] = [WZHChoicennessItem]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    //在控制器的view即将显示的时候设置navigationbar的alpha值
    override func viewDidAppear(animated: Bool) {
        if alphaValue == nil {
            return
        }
        //设置navigationbar的alpha
        navigationController?.navigationBar.alpha = alphaValue!
    }
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航条内容
        setupNavigationBarAndTabBar()
        //加载数据
        loadData()
        //添加上下拉刷新
        addRefresh()
        
        

    }
    
    //监听滚动让导航条随着滚动变为透明
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let i : CGFloat = 64
        navigationController?.navigationBar.alpha = ((0 - tableView.bounds.origin.y) / i)
        
    }
    
    //在当前控制器即将消失的时候将navigationbar的透明度保存起来
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        alphaValue = navigationController?.navigationBar.alpha
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK:- tableview代理和数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as? WZHChoicennessViewCell
        cell?.item = datas[indexPath.row]
        //给cell添加渐变并避免渐变layer重复渲染cell
        if cell?.imageV.layer.sublayers?.count < 1 {
            let gradient = CAGradientLayer();
            gradient.frame = cell!.contentView.bounds;
            gradient.colors = [UIColor.clearColor().CGColor,UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
            gradient.opacity = 0.7
            cell!.imageV.layer.insertSublayer(gradient, atIndex: 1)
        }
        return cell!
    }
    // MARK:- 监听Cell点击
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let DetailVc = WZHDetailViewController(nibName: "WZHDetailViewController", bundle: nil)
        DetailVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailVc, animated: true)
        
    }



}
// MARK:- 添加上下拉刷新
extension WZHChoicenessViewController {
    
    func addRefresh() {
        //添加下拉刷新
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        var images = [UIImage]()
        for i in 0...66 {
            
            let str = String(format: "pulldown_000%02d", i)
            let image = UIImage(named: str)
            images.append(image!)
            
        }
        
        header.setImages(images, duration: 2.0, forState: .Refreshing)
        header.lastUpdatedTimeLabel.hidden = true
        header.stateLabel.hidden = true
        self.tableView.mj_header = header
        
        //添加上拉刷新
        let footer = MJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(WZHChoicenessViewController.loadMoreData))
        var upImages = [UIImage]()
        for i in 0...66 {
            let str = String(format: "pullup_000%02d", i)
            let image = UIImage(named: str)
            upImages.append(image!)
            
        }
        
        footer.setImages(upImages, duration: 2.0, forState: .Refreshing)
        footer.refreshingTitleHidden = true
        self.tableView.mj_footer = footer
        
        
    }
}


// MARK:- 设置navigationbar和tabbar的显示
extension WZHChoicenessViewController {

    func setupNavigationBarAndTabBar() {
        
        //设置navigationbar
        let imaView = UIImageView(image: UIImage(named: "launch_title_39x18_@2x"))
        navigationItem.titleView = imaView
        let image = UIImage(named: "nav_bar_bg_2x64_" )
        
        //设置tabbar
        tabBarController?.tabBar.backgroundImage = image
        tabBarController?.tabBar.clipsToBounds = true
        
        
    }

}

// MARK:- 请求网络数据
extension WZHChoicenessViewController {
    
    func loadData() {
        
        let parameters = [String : NSObject]()
        
        WZHHttpTools.shareInstance.requestData(.GET, urlString: "http://songguolife.com/api/home", parameters: parameters) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            self.tableView.mj_header.endRefreshing()
            self.datas.removeAll()
            guard let resultArr = result as? [[String : NSObject]] else {
                return
            }
            let arr  = WZHChoicennessItem.mj_objectArrayWithKeyValuesArray(resultArr)
            for diction in arr {
                self.datas.append(diction as! WZHChoicennessItem)
            }
            self.tableView.reloadData()
        }
        
    }
    
}

// MARK:- 上拉刷新请求数据
extension WZHChoicenessViewController {

    func loadMoreData() {
        let str = self.datas.last?.ct
        var parameters = [String : NSObject]()
        parameters["until"] = str!
        WZHHttpTools.shareInstance.requestData(.GET, urlString: "http://songguolife.com/api/home", parameters: parameters) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            
            self.tableView.mj_footer.endRefreshing()
            
            guard var resultArr = result as? [[String : NSObject]] else {
                return
            }
            
            //因为刷新前的数据的最后一个数据和新数据的第一个重复,所以删除掉新数据中的第一个元素
            resultArr.removeFirst()
            let arr = WZHChoicennessItem.mj_objectArrayWithKeyValuesArray(resultArr)
            for dict in arr {
            
                self.datas.append(dict as! WZHChoicennessItem)
                
            }
            self.tableView.reloadData()
        }
        
        
    }
}




