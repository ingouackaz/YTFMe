//
//  YoutubeTopCell.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 13/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class YoutubeTopCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var dateAgoLabel: UILabel!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
