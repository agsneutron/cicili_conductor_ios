//
//  CommentsTableViewCell.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 19/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblPedido: UILabel!
    @IBOutlet weak var lblComentarios: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblCalificacion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
