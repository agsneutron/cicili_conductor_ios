//
//  BoardTableViewCell.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 21/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class BoardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDia: UILabel!
    
    @IBOutlet weak var lblMonto: UILabel!
    @IBOutlet weak var lblPipa: UILabel!
    
    @IBOutlet weak var lblConductor: UILabel!
    @IBOutlet weak var lblLitros: UILabel!
    @IBOutlet weak var lblPlanta: UILabel!
    @IBOutlet weak var lblPlacas: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
