//
//  WZHActivityItem.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/16.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHActivityItem: NSObject {

    var authorName : String?
    var title : String?
    var cityName : String?
    var imageUrl : String = ""
    
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["authorName":"address",
                "cityName":"geo.city.name",
                "title":"name",
                "imageUrl":"topImage.url"
            ]
    }
}
