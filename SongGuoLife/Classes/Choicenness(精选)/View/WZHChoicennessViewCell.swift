//
//  WZHChoicennessViewCell.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/12.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import SDWebImage

class WZHChoicennessViewCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressView: UIImageView!
    @IBOutlet weak var markActivity: UIButton!

    var item : WZHChoicennessItem? {
        didSet {
            
            if item?.type == 1 {
                
                //设置图片
                let url = item?.imageName
                let imageUrl = NSURL(string: url ?? "")
                imageV?.sd_setImageWithURL(imageUrl, placeholderImage: nil, completed: { (image : UIImage!, _, _, _) in
                    if image == nil {
                        return
                    }
                    
                    self.imageV.frame = self.calculateImageViewSize(image)
                })
                
                //设置文字部分展示
                self.titleLabel.text = item?.name
                self.subTitle.text = item?.author
                let string = item?.addressName
                self.markActivity.hidden = false
                self.addressView.hidden = false
                self.addressLabel.hidden = false
                //截取cell右下角地址去掉地级单位
                let endIndex = string?.endIndex.advancedBy(-1)
                self.addressLabel.text = string?.substringToIndex(endIndex!)
            } else {
            
                //设置图片
                let url = item?.imageNameN
                let imageUrl = NSURL(string: url ?? "")
                imageV?.sd_setImageWithURL(imageUrl)
                self.addressLabel.hidden = true
                self.markActivity.hidden = true
                self.addressView.hidden = true
                //设置文字部分展示
                self.titleLabel.text = item?.nameN
                let string = item?.authorN
                let str = "by \(string!)"
                self.subTitle.text = str
                
            }
        }
    }
    
}



extension WZHChoicennessViewCell {
    
    
    func calculateImageViewSize(image : UIImage) -> CGRect {
        
        //获取图片尺寸
        let imageSize = image.size
        
        //计算w,h,x,y
        let w = UIScreen.mainScreen().bounds.width
        let h = w / imageSize.width * imageSize.height
        let x : CGFloat = 0;
        let y = (UIScreen.mainScreen().bounds.height - h) * 0.5
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    


}


