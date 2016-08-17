//
//  TableViewCell2.swift
//  Sommerjobben
//
//  Created by Joakim Nereng Ellestad on 10.01.2016.
//  Copyright © 2016 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var earnedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
