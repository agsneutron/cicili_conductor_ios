//
//  TankTruckViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 21/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class TankTruckViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))

        // Do any additional setup after loading the view.
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
       navigationController?.setNavigationBarHidden(true, animated: true)
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
