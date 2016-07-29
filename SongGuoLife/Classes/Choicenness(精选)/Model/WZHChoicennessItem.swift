//
//  WZHChoicennessItem.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import MJExtension

class WZHChoicennessItem: NSObject {
    
    //定义属性
    /*********首页*************/
    var type : CGFloat = 0.0//类型
    // MARK:- 活动类型
    var name : String?//标题
    var author : String?//副标题
    var imageName : String = ""//图片名称
    var addressName : String?//地址名称
    var imageW : CGFloat?//图片宽度
    var imageH : CGFloat?//图片高度
    // MARK:- 非活动类型
    var nameN : String?//标题
    var authorN : String?//副标题
    var imageNameN : String = ""//图片名称
    var ct : String?//请求更多数据关键字
    
    
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return [
                //活动类型
                "addressName":"activity.geo.city.name",
                "imageName":"activity.topImage.url",
                "imageW":"activity.topImage.width",
                "imageH":"activity.topImage.height",
                "name":"activity.name",
                "author":"activity.address",
                //非活动类型
                "nameN":"article.title",
                "authorN":"article.user.nick",
                "imageNameN":"article.topImage.url"
        ]
        
    }
    
    
}
