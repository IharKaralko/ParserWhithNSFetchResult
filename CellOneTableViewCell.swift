//
//  CellOneTableViewCell.swift
//  MyXMLParserDemo
//
//  Created by Ihar Karalko on 7/19/17.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import UIKit

class CellOneTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pubDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
