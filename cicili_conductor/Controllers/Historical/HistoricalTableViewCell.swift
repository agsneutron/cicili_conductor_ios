//
//  HistoricalTableViewCell.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 20/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class HistoricalTableViewCell: UITableViewCell {

    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var monto: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var formaPago: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
