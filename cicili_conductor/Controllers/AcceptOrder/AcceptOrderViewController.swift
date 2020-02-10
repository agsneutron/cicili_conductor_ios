//
//  AcceptOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import UIKit

class AcceptOrderViewController: UIViewController {

    var cliente: Cliente?

    
    
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet  var txtDriver: UILabel!
    @IBOutlet  var txtStatus: UILabel!
    
    @IBOutlet var txtQuantity: UILabel!
    @IBOutlet var txtPayment: UILabel!
    @IBOutlet var txtHour: UILabel!
    @IBOutlet var txtDate: UILabel!
    @IBOutlet var txtAmount: UILabel!
    
    @IBOutlet weak var requestedOrder: UIView!
    
   
    
    let idPedido = "idPedido"
    let pstatus = "status"
    let pQuantity = "quantity"
    let pPayment = "payment"
    let pHour = "hour"
    let pDate = "date"
    let pAmount = "amount"

    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.cliente = appDelegate.responseCliente
        
        /*navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))*/

        // Do any additional setup after loading the view.
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if varPedido != nil {

            self.getPedido(pidPedido: varPedido!)
        }
        
        
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    
    func getPedido(pidPedido: String) {
    
        
        let fbToken = appDelegate.FBToken
        print("Token FB : \(fbToken)")
           
        RequestManager.getOrderData(oauthToken: cliente!.token!, idPedido: pidPedido, success: { response in
                        
            debugPrint("En success requestorder \(response.direccion!)")
            
            self.txtTitle.text = "Pedido: \(response.id)"
            self.txtStatus.text = "\(response.nombreStatus!) "
            self.txtDate.text = "Fecha: \(response.fechaSolicitada!)"
            self.txtHour.text = "Hora: \(response.horaSolicitada!) "
            self.txtPayment.text = "Forma de Pago: \(response.formaPago!) "
            self.txtQuantity.text = "Cantidad: \(response.cantidad)"
            self.txtAmount.text = "Precio: \(response.precio) "
            
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
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
    
    
    @IBAction func sendAcceptOrder(_ sender: Any) {
        acceptOrder()
        
    }
    
    func acceptOrder() {
    
        
        let fbToken = appDelegate.FBToken
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
           
        RequestManager.acceptOrder(oauthToken: cliente!.token!, parameters: [WSKeys.parameters.pedido: varPedido ?? 0], success: { response in
                        
            debugPrint("En success requestorder \(response.codeError)")
            self.performSegue(withIdentifier: Constants.Storyboard.segueAcceptOrder, sender: self)
            
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
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
