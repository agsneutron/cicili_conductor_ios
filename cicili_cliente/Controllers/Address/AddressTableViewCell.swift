//
//  AddressTableViewCell.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 10/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
