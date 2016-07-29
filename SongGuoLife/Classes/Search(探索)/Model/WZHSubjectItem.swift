//
//  WZHSubjectItem.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/15.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHSubjectItem: NSObject {

    var title : String?
    var imageUrl : String?

    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return [
            "imageUrl":"topImage.url"
        ]
    }

    
}
