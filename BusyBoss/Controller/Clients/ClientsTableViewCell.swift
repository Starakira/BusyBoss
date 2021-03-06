//
//  ClientsTableViewCell.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class ClientsTableViewCell: UITableViewCell {
    @IBOutlet weak var clientsImage: UIImageView!
    @IBOutlet weak var clientsLabel: UILabel!
    @IBOutlet weak var clientsCompanyName: UILabel!
    @IBOutlet weak var clientsCompanyAddress: UILabel!
    @IBOutlet weak var clientsPhoneNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clientsImage.layer.borderWidth = 1
        clientsImage.layer.masksToBounds = false
        clientsImage.layer.borderColor = UIColor.clear.cgColor
        clientsImage.layer.cornerRadius = clientsImage.frame.height/2
        clientsImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
