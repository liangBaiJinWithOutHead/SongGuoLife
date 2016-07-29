//
//  WZHSearchViewController.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import MJExtension

private let typeID = "typeCell"
private let staticID = "static"
private let bottomID = "bottom"

class WZHSearchViewController: UIViewController {
    
    
    private var plistData : [WZHSearchItem] = [WZHSearchItem]()
    private var datas :[WZHLifeItem] = [WZHLifeItem]()
    private var subjects : [WZHSubjectItem] = [WZHSubjectItem]()
    private var number : Int?
    // MARK:- 控件属性(顶部)
    @IBOutlet weak var scrollV: UIScrollView!
    @IBOutlet weak var collectionV: UICollectionView!
    
    @IBOutlet weak var heightYS: NSLayoutConstraint!
    
    @IBOutlet weak var searchView: UISearchBar!
    // MARK:- 控件属性(中间)
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var collectionVMid : UICollectionView!
    // MARK:- 控件属性(底部)
    
    @IBOutlet weak var tableViewBottom: UITableView!
    
    /*
     重写viewdidappear方法,在这里面设置scrollview的contensize,
     用autolayout对于有约束动画效果的页面很危险,
     推荐用这种方式安全的让scrollview达到正常滚动的效果
     */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scrollV.contentSize = CGSize(width: 0, height: 893)
        
    }
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.tintColor = UIColor.orangeColor()
        searchView.backgroundImage = UIImage()
        scrollV.backgroundColor = UIColor(red: 233 / 255.0, green: 225 / 255.0, blue: 210 / 255.0, alpha: 1)
        //隐藏控制器的navigationbar并取消scrollview的默认内边距
        navigationController?.navigationBar.hidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        //设置上中下三部分视图显示
        setupTopView()
        setupMiddleView()
        setupBottomView()
    }

    // MARK:- 点击查看所有分类按钮
    @IBAction func click(sender: UIButton) {
        
        sender.selected = !sender.selected
        if sender.selected == true {
        
            heightYS.constant = 370
            UIView.animateWithDuration(0.3) {
                self.view.layoutIfNeeded()
                //重新判断设置scrollview的contensize否则会不能滚动
                self.scrollV.contentSize = CGSize(width: 0, height: 1135)
            }
        } else if sender.selected == false {
        
            heightYS.constant = 128
            UIView.animateWithDuration(0.3, animations: {
                self.view.layoutIfNeeded()
                //重新判断设置scrollview的contensize否则不能滚动
                self.scrollV.contentSize = CGSize(width: 0, height: 893)
            })
        }
    }
}

// MARK:- 设置顶部view的内容
extension WZHSearchViewController {
    func setupTopView() {
    
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = UIColor.whiteColor()
        collectionV.scrollEnabled = false
        //加载plist中的文件
        let path = NSBundle.mainBundle().pathForResource("types", ofType: "plist")
        let datas = NSArray(contentsOfFile: path!) as? [[String : NSObject]]
        let arr = WZHSearchItem.mj_objectArrayWithKeyValuesArray(datas)
        for item in arr {
            plistData.append(item as! WZHSearchItem)
        }
        collectionV.reloadData()
    }
}

// MARK:- collectionView数据源和代理方法
extension WZHSearchViewController : UICollectionViewDataSource, UICollectionViewDelegate {

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionV  {
            
            return plistData.count
        }
        return datas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionV {
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(typeID, forIndexPath: indexPath) as? WZHTypeViewCell
            
            cell!.item = plistData[indexPath.row]
            return cell!
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(staticID, forIndexPath: indexPath) as? WZHStaticViewCell
        cell?.life = datas[indexPath.row]
        
        return cell!
    }
    
    // MARK:- 写到这里了
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
    }
    
}
// MARK:- 设置中间视图
extension WZHSearchViewController {

    func setupMiddleView() {
    
        collectionVMid.delegate = self
        collectionVMid.dataSource = self
        collectionVMid.backgroundColor = UIColor.whiteColor()
        loadMidData(0)
    }
}
// MARK:- 中间视图请求数据
extension WZHSearchViewController {
    
    func loadMidData(i : Int) {
        let parameters = ["count" : 4, "from" : i]
        number = i
        WZHHttpTools.shareInstance.requestData(.GET, urlString: "http://songguolife.com/api/author/recommend", parameters: parameters ) { (result, error) in
            if error != nil {
                return
            }
            
            guard let dictArr = result as? [[String : NSObject]] else {
                return
            }
            let arr = WZHLifeItem.mj_objectArrayWithKeyValuesArray(dictArr)
            self.datas.removeAll()
            for dict in arr {
            
                self.datas.append(dict as! WZHLifeItem)
            }
            
            self.collectionVMid.reloadData()
        }
        
    }
    
}
// MARK:- 点击中间界面的换一换来刷新中间的视图
extension WZHSearchViewController {
    
    @IBAction func refreshBtnClick(sender: AnyObject) {
        loadMidData((number! + 4))
    }
}


// MARK:- 设置底部视图
extension WZHSearchViewController {

    func setupBottomView() {
        tableViewBottom.delegate = self
        tableViewBottom.dataSource = self
        tableViewBottom.scrollEnabled = false
        loadBottomViewData()
        
    }
}

// MARK:- 底部视图的数据源和代理方法
extension WZHSearchViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(bottomID, forIndexPath: indexPath) as? WZHBottomViewCell
        cell?.item = subjects[indexPath.row]
        
        return cell!
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {

    }
    
}

// MARK:- 请求底部视图的数据
extension WZHSearchViewController {

    func loadBottomViewData() {
        let parameters = [String : NSObject]()
        WZHHttpTools.shareInstance.requestData(.GET, urlString: "http://songguolife.com/api/topic", parameters: parameters) { (result, error) in
           
            if error != nil {
                return
            }
            
            guard let dictArr = result as? [[String : NSObject]] else {
                return
            }
            let arr = WZHSubjectItem.mj_objectArrayWithKeyValuesArray(dictArr)
            for dict in arr {
            
                self.subjects.append(dict as! WZHSubjectItem)
            }
            
            self.tableViewBottom.reloadData()
        }
        
    }
}





