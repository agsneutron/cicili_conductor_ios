//
//  usuarioViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 17/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class usuarioViewController: UIViewController {
    @IBOutlet weak var perfilView: UIView!
    @IBOutlet weak var direccionesView: UIView!
    @IBOutlet weak var circularImage: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        circularImage.layer.masksToBounds = true
        circularImage.layer.cornerRadius = circularImage.bounds.width / 2
        circularImage.layer.borderColor = UIColor.white.cgColor
        circularImage.layer.borderWidth = 5
       }

    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            perfilView.alpha = 0
            direccionesView.alpha = 1
        } else {
            perfilView.alpha = 1
            direccionesView.alpha = 0
        }
    }
}
