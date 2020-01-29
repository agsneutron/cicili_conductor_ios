//
//  HideCursor.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 28/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class HideCursor: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

}
