//
//  WZHBottomViewCell.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/14.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit

class WZHBottomViewCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var title: UILabel!

    var item : WZHSubjectItem? {
        
        didSet {
            
            let url = item!.imageUrl
            imageV.sd_setImageWithURL(NSURL(string: url!))
            title.text = item!.title
            
        }
    }


}
