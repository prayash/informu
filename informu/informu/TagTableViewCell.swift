//
//  TagTableViewCell.swift
//  informu
//
//  Created by Prayash Thapa on 12/8/16.
//  Copyright © 2016 Prayash Thapa. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
