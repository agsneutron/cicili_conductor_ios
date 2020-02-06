//
//  AcceptOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class AcceptOrderViewController: UIViewController {

    @IBOutlet var txtTitle: UILabel!
    @IBOutlet  var txtDriver: UILabel!
    @IBOutlet  var txtStatus: UILabel!
    
    @IBOutlet var txtQuantity: UILabel!
    @IBOutlet var txtPayment: UILabel!
    @IBOutlet var txtHour: UILabel!
    @IBOutlet var txtDate: UILabel!
    @IBOutlet var txtAmount: UILabel!
    
    let idPedido = "idPedido"
    let pstatus = "status"
    let pdriver = "driver"
    let pQuantity = "quantity"
    let pPayment = "payment"
    let pHour = "hour"
    let pDate = "date"
    let pAmount = "amount"

    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))

        // Do any additional setup after loading the view.
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        var varStatus: String? = nil
        var varDriver: String? = nil
        var varQuantity: String? = nil
        var varPayment: String? = nil
        var varHour: String? = nil
        var varDate: String? = nil
        var varAmount: String? = nil
        
        if varPedido == nil {
            varPedido = notif?[idPedido] as? String
            varStatus = notif?[pstatus] as? String
            varDriver = notif?[pdriver] as? String
            varQuantity = notif?[pQuantity] as? String
            varPayment = notif?[pPayment] as? String
            varHour = notif?[pHour] as? String
            varDate = notif?[pDate] as? String
            varAmount = notif?[pAmount] as? String
            
            self.txtTitle.text = "Pedido: \(varPedido!)"
            self.txtStatus.text = "\(varStatus!) "
            self.txtDriver.text = "Conductor: \(varDriver!) "
            self.txtDate.text = "\(varDate!)"
            self.txtHour.text = "\(varHour!) "
            self.txtPayment.text = "\(varPayment!) "
            self.txtQuantity.text = "\(varQuantity!)"
            self.txtAmount.text = "\(varAmount!) "
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationResponse(notification:)), name: Notification.Name("NotificationResponse"), object: nil)
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func NotificationResponse(notification: Notification){
        print("Leego notificacion")
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        var varStatus: String? = nil
        var varDriver: String? = nil
        var varQuantity: String? = nil
        var varPayment: String? = nil
        var varHour: String? = nil
        var varDate: String? = nil
        var varAmount: String? = nil
        
        if varPedido == nil {
            varPedido = notif?[idPedido] as? String
            varStatus = notif?[pstatus] as? String
            varDriver = notif?[pdriver] as? String
            varQuantity = notif?[pQuantity] as? String
            varPayment = notif?[pPayment] as? String
            varHour = notif?[pHour] as? String
            varDate = notif?[pDate] as? String
            varAmount = notif?[pAmount] as? String
            
            self.txtTitle.text = "Pedido: \(varPedido!)"
            self.txtStatus.text = "\(varStatus!) "
            self.txtDriver.text = "Conductor: \(varDriver!) "
            self.txtDate.text = "\(varDate!)"
            self.txtHour.text = "\(varHour!) "
            self.txtPayment.text = "\(varPayment!) "
            self.txtQuantity.text = "\(varQuantity!)"
            self.txtAmount.text = "\(varAmount!) "
        }
    }
    
    func sendDataNotification(){
        print("Leego notificacion")
        let notif = appDelegate.responseNotification
        var pedido: String? = nil
        if pedido == nil {
            pedido = notif?[idPedido] as? String
            self.txtTitle.text = " ¡ Hola \(pedido!) ! "
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
