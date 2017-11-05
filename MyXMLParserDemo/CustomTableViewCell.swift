//
//  CustomTableViewCell.swift
//  MyXMLParserDemo
//
//  Created by Ihar Karalko on 7/6/17.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    func configure(title:String, date: String, imageUrl: String, imageData: Data?) {
        self.titleLabel.text = title
        self.pubDateLabel.text = date
        if imageData == nil {return}
        let image = UIImage(data: imageData!)
        self.thumbnailImageView.image = image
        
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 52.5
    }
    
}
