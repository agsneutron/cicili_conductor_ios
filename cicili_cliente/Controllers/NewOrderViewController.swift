//
//  NewOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import Foundation

class NewOrderViewController: UIViewController {

    @IBOutlet weak var lblStatusOrder: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var btnCancel: RoundButton!

    @IBOutlet weak var lblHeaderOrderStatus: UILabel!
    @IBOutlet weak var lblHeaderOrderNumber: UILabel!
    var cliente: Cliente?
    var order: NewOrder?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint("inNewOrder")
        debugPrint(order!)
        debugPrint(message!)
        // Do any additional setup after loading the view.
        
        lblStatusOrder.text = ""
        lblOrderNumber.text = ""
        if message != "" {
            btnCancel.isHidden = true
            lblHeaderOrderNumber.text = ""
            lblHeaderOrderStatus.text = ""
            lblStatusOrder.text = Constants.ErrorMessages.messageNewOrderError
            lblOrderNumber.text = message!
            
        }
        else{
            lblHeaderOrderNumber.text = Constants.textAction.lblHeaderOrderNumber
            lblHeaderOrderStatus.text = Constants.textAction.lblHeaderOrderStatus
            lblStatusOrder.text = order?.nombreStatus
            lblOrderNumber.text = "\(order?.id ?? 0)"
        }
        
        
       
    }
    

    @IBAction func btnOrder(_ sender: RoundButton) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: RoundButton) {
        
        RequestManager.fetchCancelReason(oauthToken: self.cliente!.token! , success: { response in
           
                       print("En success get cancel reason \(response)")
                       
            
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
