//
//  TableViewCell.swift
//  ex4Swift
//
//  Created by VuHongSon on 7/19/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
