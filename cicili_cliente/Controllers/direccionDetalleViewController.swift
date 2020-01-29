//
//  direccionDetalleViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 27/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import UIKit

class direccionDetalleViewController: UIViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
            
      let backButton = UIBarButtonItem()
      backButton.title = "Regresar"
      self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
       
         self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
    }
 
   
    
}
