//
//  GoodsTableViewCell.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class GoodsTableViewCell: UITableViewCell {
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsLabel: UILabel!
    @IBOutlet weak var goodsStock: UILabel!
    @IBOutlet weak var goodsPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
