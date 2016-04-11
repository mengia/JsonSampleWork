//
//  DisplayTableViewCell.swift
//  JsonSampleWork
//
//  Created by Mengistayehu Mamo on 4/7/16.
//  Copyright © 2016 Mengistayehu Mamo. All rights reserved.
//

import UIKit

class DisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var use: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib() 
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
