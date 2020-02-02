//
//  NewOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {

    @IBOutlet weak var lblStatusOrder: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    
    var cliente: Cliente?
    var order: Response?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        debugPrint(order!)
        // Do any additional setup after loading the view.
        
        lblStatusOrder.text = ""
        lblOrderNumber.text = ""
        
        
       
    }
    

    @IBAction func btnOrder(_ sender: RoundButton) {
    }
    
    @IBAction func btnCancel(_ sender: RoundButton) {
        
        RequestManager.fetchClientStatus(oauthToken: self.cliente!.token! , success: { response in
                   if let statusUpdated = response.status, !statusUpdated.isEmpty{
                       print("En success get cancel reason \(statusUpdated)")
                       
            }
               })
               { error in
                  debugPrint("---ERROR---")
               }
               
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
