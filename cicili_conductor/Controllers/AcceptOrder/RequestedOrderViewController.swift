//
//  RequestedOrderViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 09/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class RequestedOrderViewController: UIViewController {

    @IBOutlet weak var txtDireccion: UILabel!
    @IBOutlet weak var txtPrecio: UILabel!
    @IBOutlet weak var txtCantidad: UILabel!
    @IBOutlet weak var txtFormaPago: UILabel!
    @IBOutlet weak var txtTiempo: UILabel!
    @IBOutlet weak var txtDistancia: UILabel!
    @IBOutlet weak var txtCliente: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtPedido: UILabel!
    
    let idPedido = "idPedido"
    let pstatus = "status"
    var cliente: Cliente?
    
    let latitude = 19.2508805
    let longitude = -99.6039988
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        getDataOrder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationResponse(notification:)), name: Notification.Name("NotificationResponse"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func NotificationResponse(notification: Notification){
        print("Leego notificacion")
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if varPedido != nil {
            
            self.txtStatus.text = notif?[pstatus] as? String
        }
    }
    
    func getDataOrder(){
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        if varPedido != nil {
            getPedido(pidPedido: varPedido!)
            
        }
    }
    
    func getPedido(pidPedido: String) {
    
        
        let fbToken = appDelegate.FBToken
        print("Token FB : \(fbToken)")
           
        RequestManager.getOrderData(oauthToken: cliente!.token!, idPedido: pidPedido, success: { response in
            self.txtDireccion.text = "Dirección: \(response.direccion!)"
            self.txtPrecio.text = "Precio: \(response.precio)"
            self.txtCantidad.text = "Cantidad: \(response.cantidad)"
            self.txtFormaPago.text = "Forma Pago: \(response.formaPago!)"
            self.txtTiempo.text = "Llegada: \(response.tiempo!)"
            self.txtDistancia.text = "Distancia: \(response.distancia!)"
            self.txtCliente.text = "Cliente: \(response.nombreCliente!)"
            self.txtStatus.text = "\(response.nombreStatus!)"
            self.txtPedido.text = "Pedido: \(response.id)"
            
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

    @IBAction func openGoogleMaps(_ sender: RoundButton) {
      if let UrlNavigation = URL.init(string: "comgooglemaps://") {
          if UIApplication.shared.canOpenURL(UrlNavigation){
              if self.longitude != nil && self.latitude != nil {

                  let lat = (self.latitude)
                  let longi = (self.longitude)

                  if let urlDestination = URL.init(string: "comgooglemaps://?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                      UIApplication.shared.openURL(urlDestination)
                  }
              }
          }
          else {
              NSLog("Can't use comgooglemaps://");
              self.openTrackerInBrowser()

          }
      }
      else
      {
          NSLog("Can't use comgooglemaps://");
         self.openTrackerInBrowser()
      }
    }
    func openTrackerInBrowser(){
            if self.longitude != nil && self.latitude != nil {

                let lat = (self.latitude)
                let longi = (self.longitude)

                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                    UIApplication.shared.openURL(urlDestination)
                }
            }
    }
    
    
    @IBAction func openWaze(_ sender: RoundButton) {
        //let location =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
