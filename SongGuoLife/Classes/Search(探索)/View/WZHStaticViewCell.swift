//
//  WZHStaticViewCell.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/14.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import SDWebImage

class WZHStaticViewCell: UICollectionViewCell {

    @IBOutlet weak var nickView: UILabel!
    @IBOutlet weak var iconView: UIImageView!

    var life : WZHLifeItem? {
        didSet {
            //设置图片
            let url = life?.icon
            let imageUrl = NSURL(string: url!)
            iconView.sd_setImageWithURL(imageUrl, placeholderImage: nil) { (image , _, _, _) in
                
                //画出圆形图片
                UIGraphicsBeginImageContextWithOptions(self.iconView.bounds.size, false, 0.0)
                let ctx = UIGraphicsGetCurrentContext()
                let rect = CGRectMake(0, 0, self.iconView.bounds.width, self.iconView.bounds.height)
                CGContextAddEllipseInRect(ctx, rect)
                CGContextClip(ctx)
                self.iconView.drawRect(rect)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                self.iconView.image = image
                
            }
            
            //设置文字
            nickView.text = life?.nick
            
        }
    }

}

