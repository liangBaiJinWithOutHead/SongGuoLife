//
//  WZHActivityViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

private let ID = "Activity"


class WZHActivityViewController: WZHBaseViewController {

    private var datas : [WZHActivityItem] = [WZHActivityItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "WZHActivityViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: ID)

        //设置导航条
        setupNavigationBar()
       
        //加载数据
        loadData()
    }
  
    // MARK:- tableview代理和数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as? WZHActivityViewCell
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


}

extension WZHActivityViewController {

    func setupNavigationBar() {
    
        navigationItem.title = "活动"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(18),NSForegroundColorAttributeName:UIColor.orangeColor() ]
    
    }
}

// MARK:- 请求网络数据
extension WZHActivityViewController {
    
    func loadData() {
        
        let parameters = [String : NSObject]()
        
        WZHHttpTools.shareInstance.requestData(.GET, urlString: "http://songguolife.com/api/activity", parameters: parameters) { (result, error) in
            
            if error != nil {
                print(error)
                return
            }
            guard let resultArr = result as? [[String : NSObject]] else {
                return
            }
            let arr  = WZHActivityItem.mj_objectArrayWithKeyValuesArray(resultArr)
            for diction in arr {
                self.datas.append(diction as! WZHActivityItem)
            }
            self.tableView.reloadData()
        }
        
    }
    
}

