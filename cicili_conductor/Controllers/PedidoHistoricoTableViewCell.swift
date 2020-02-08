//
//  PedidoHistoricoTableViewCell.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 30/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class PedidoHistoricoTableViewCell: UITableViewCell {

   // @IBOutlet weak var tituloPedidoDetalle: UILabel!
    //@IBOutlet weak var direccionLabel: UILabel!
    
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var tituloPedidoDetalle: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var litrosLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    
    @IBOutlet weak var ContentCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ContentCardView.layer.cornerRadius = 20.0
          ContentCardView.layer.shadowColor = UIColor.gray.cgColor
          ContentCardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
          ContentCardView.layer.shadowRadius = 9.0
          ContentCardView.layer.shadowOpacity = 0.6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
