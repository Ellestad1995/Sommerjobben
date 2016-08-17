//
//  TableViewCell.swift
//  
//
//  Created by Joakim Nereng Ellestad on 07.11.2015.
//
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelJobName: UILabel!
    
    @IBOutlet weak var labelJobID: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
