//
//  MainViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class MainViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController: ViewController = ViewController()
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
