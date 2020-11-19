//
//  ClientContactTableViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ClientContactTableViewCell: UITableViewCell {

    @IBOutlet weak var NameContactClient: UILabel!
    @IBOutlet weak var NameCompanyClient: UILabel!
    @IBOutlet weak var AddressCompanyClient: UILabel!
    @IBOutlet weak var NumberTelephoneCompany: UILabel!
    @IBOutlet weak var LogoCompanyClient: UIImageView!
    @IBOutlet weak var LogoBuildingCompany: UIImageView!
    @IBOutlet weak var LogoPhone: UIImageView!
    @IBOutlet weak var LogoAddress: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
