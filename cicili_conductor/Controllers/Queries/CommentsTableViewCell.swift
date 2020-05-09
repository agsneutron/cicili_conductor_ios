//
//  CommentsTableViewCell.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 19/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var starStackQualification: UIStackView!
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblPedido: UILabel!
    @IBOutlet weak var lblComentarios: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblCalificacion: UILabel!
    
    @IBOutlet weak var ContentCardView: UIView!
     var imageViewC: UIImageView!
    var arrImageViews = [UIImageView]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ContentCardView.layer.cornerRadius = 20.0
          ContentCardView.layer.shadowColor = UIColor.gray.cgColor

        
        starStackQualification.distribution = .fillEqually
        starStackQualification.alignment = .fill
        starStackQualification.spacing = 5
        starStackQualification.tag = 5007
        
        
        for i in 0..<5{
            imageViewC = UIImageView()
            imageViewC.image = UIImage(named: "icon_star")
            
            starStackQualification.addArrangedSubview(imageViewC)
            arrImageViews.append(imageViewC)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
