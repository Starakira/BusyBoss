//
//  completeTransactionViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class CompleteTransactionViewCell: UITableViewCell {

    
    @IBOutlet weak var CodeTransactionLabel: UILabel!
    @IBOutlet weak var NameUserLabel: UILabel!
    @IBOutlet weak var DescriptionTransactionLabel: UILabel!
    @IBOutlet weak var StatusTransactionLabel: UILabel!
    @IBOutlet weak var TotalJumlahLabel: UILabel!
    @IBOutlet weak var GambarTransaction: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
