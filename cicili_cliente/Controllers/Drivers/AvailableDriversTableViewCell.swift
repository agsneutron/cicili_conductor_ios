//
//  AvailableDriversTableViewCell.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 16/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class AvailableDriversTableViewCell: UITableViewCell {
    
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
