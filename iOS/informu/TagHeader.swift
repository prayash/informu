//
//  TagHeader.swift
//  informu
//
//  Created by Prayash Thapa on 2/18/17.
//  Copyright © 2017 Prayash Thapa. All rights reserved.
//

import LBTAComponents

class TagHeader: DatasourceCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "TAGS"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 136, g: 136, b: 136)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 130, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(headerLabel)
        headerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class TagFooter: DatasourceCell {
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "More suggestions"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(r: 136, g: 136, b: 136)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        
        addSubview(whiteBackgroundView)
        addSubview(footerLabel)
        
        footerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        whiteBackgroundView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

