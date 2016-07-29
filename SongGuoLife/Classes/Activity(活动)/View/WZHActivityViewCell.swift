//
//  WZHActivityViewCell.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/16.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import SDWebImage

class WZHActivityViewCell: UITableViewCell {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    var item : WZHActivityItem? {
    
        didSet {
            let url = item!.imageUrl
            
            imageV.sd_setImageWithURL(NSURL(string: url))
            
            let str = item?.cityName
            
            let endIndex = str?.endIndex.advancedBy(-1)
            self.addressLabel.text = str?.substringToIndex(endIndex!)
            self.titleLabel.text = item?.title
            self.subtitleLabel.text = item?.authorName
            
        }
        
    }
}
