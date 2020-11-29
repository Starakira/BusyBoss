//
//  ServicesTableViewCell.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var servicesPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
