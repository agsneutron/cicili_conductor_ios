//
//  PedidosViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 29/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class PedidosViewController: UIViewController {
   
    @IBOutlet weak var programarView: UIView!
    @IBOutlet weak var pedidosView: UIView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.

       }

    
    @IBAction func PedidoswitchView(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
        programarView.alpha = 0
        pedidosView.alpha = 1
    } else {
        programarView.alpha = 1
        pedidosView.alpha = 0
    }
    }
    
    

}
