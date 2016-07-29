//
//  WZHBaseViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/16.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

import UIKit

private let ID = "Choice"
class WZHBaseViewController: UITableViewController {
    
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册自定义cell
        let nib = UINib(nibName: "WZHChoicennessViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: ID)
        
        self.tableView.separatorStyle = .None
        
        tableView.backgroundColor = UIColor(red: 233 / 255.0, green: 225 / 255.0, blue: 210 / 255.0, alpha: 1)
        
        //去掉开始启动程序出现的系统默认设置的tableviewcell的样式
        tableView.tableFooterView = UIView()
    }
    
    
    
      
    
    //设置cell的指定高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 270
    }
    
}



