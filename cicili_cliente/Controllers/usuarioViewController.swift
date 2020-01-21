//
//  usuarioViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 17/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class usuarioViewController: UIViewController {
    @IBOutlet weak var circularImage: UIImageView!
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        circularImage.layer.masksToBounds = true
        circularImage.layer.cornerRadius = circularImage.bounds.width / 2
        circularImage.layer.borderColor = UIColor.white.cgColor
        circularImage.layer.borderWidth = 5
       }
}
