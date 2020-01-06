//
//  DIsmissSegue.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    
    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
