//
//  AddTagCell.swift
//  informu
//
//  Created by Prayash Thapa on 2/19/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import UIKit

class AddTagCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(tagImageView)
        
        tagImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        tagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tagImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tagImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
