//
//  MemeCVCell.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 21/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class MemeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    
    override func awakeFromNib() {
        self.contentView.frame = self.bounds;
        self.contentView.autoresizingMask = [ UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    }
}
