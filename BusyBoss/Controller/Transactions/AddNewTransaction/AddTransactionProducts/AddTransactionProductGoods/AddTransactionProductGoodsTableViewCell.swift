//
//  ProductListBarangViewCell.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class AddTransactionProductGoodsTableViewCell: UITableViewCell {

    @IBOutlet weak var NamaBarangLabel: UILabel!
    @IBOutlet weak var JumlahStockBarang: UILabel!
    @IBOutlet weak var TotalHargaLabel: UILabel!
    @IBOutlet weak var GambarBarang: UIImageView!
    @IBOutlet weak var PlusMinus: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
