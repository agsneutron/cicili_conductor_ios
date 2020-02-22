//
//  DocumentsTableViewCell.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 22/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblDocument: UILabel!
    @IBOutlet weak var lblFileName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
