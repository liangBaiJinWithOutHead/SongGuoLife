//
//  WZHTypeViewCell.swift
//  SongGuoLife
//
//  Created by 王振晗 on 16/7/15.
//  Copyright © 2016年 王振晗. All rights reserved.
//

import UIKit
import SDWebImage

class WZHTypeViewCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var item : WZHSearchItem? {
        didSet {
            
                imageV.image = UIImage(named: item?.icon ?? "")
                nameLabel.text = item?.title
        }

    }

}

