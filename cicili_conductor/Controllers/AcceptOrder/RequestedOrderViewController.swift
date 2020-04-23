//
//  RequestedOrderViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 09/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RequestedOrderViewController: UIViewController, DataCancelDelegate {

    @IBOutlet weak var txtDireccion: UILabel!
    @IBOutlet weak var txtPrecio: UILabel!
    @IBOutlet weak var txtCantidad: UILabel!
    @IBOutlet weak var txtFormaPago: UILabel!
    @IBOutlet weak var txtTiempo: UILabel!
    @IBOutlet weak var txtDistancia: UILabel!
    @IBOutlet weak var txtCliente: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtPedido: UILabel!
    
    let indexStatus = "status"
    var message: String?
    var cancelReasons: [ReusableIdText] = []
    var responseCancel: Response?
    var reason: String?
    
    @IBOutlet weak var btnProcessOrder: RoundButton!
    
    @IBOutlet weak var btnCancel: RoundButton!
    
    var location: CLLocationCoordinate2D?
    var stringDireccion: String?
    let idPedido = "idPedido"
    let pstatus = "nombreStatus"
    var cliente: Cliente?
    
    //let latitude = 19.2508805
    //let longitude = -99.6039988
    var latitude: Double = 0.0
    let longitude: Double = 0.0
    
    //cancel cardview
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController:CancelOrderViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 500
    let cardHandleAreaHeight:CGFloat = 0
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    var pedidoActivo: String? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        setupCard()
        navigationController?.setNavigationBarHidden(true, animated: true)
        getDataOrder()
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationResponse(notification:)), name: Notification.Name("NotificationResponse"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func NotificationResponse(notification: Notification){
        print("Leego notificacion")
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        var varStatus: String? = nil
        varStatus = notif?[indexStatus] as? String
        
        if (varPedido == nil){
            if (pedidoActivo != nil){
                varPedido = String(pedidoActivo!)
            }
        }
        
        if varPedido != nil {
            
            self.txtStatus.text = notif?[pstatus] as? String
            switch varStatus {
            case "12":
                self.getDataOrder()
                self.customAlertController(tittle_t: Constants.AlertTittles.titleOrderUpdated, message_t: Constants.AlertMessages.messageOrderUpdated, buttonAction: Constants.textAction.actionOK, doHandler: self.updateAction)
            case "20":
                 self.OpenChat()
            default:
                if (varStatus == "3"){
                   self.customAlertController(tittle_t: Constants.AlertTittles.titleOrderCanceled, message_t: Constants.AlertMessages.messageOrderCanceled, buttonAction: Constants.textAction.actionOK, doHandler: self.closeViewController)
                }
            }
        }
    }
    
    func closeViewController(action: UIAlertAction){
        let controllers = self.navigationController?.viewControllers
         for vc in controllers! {
           if vc is MainTabController {
             _ = self.navigationController?.popToViewController(vc as! MainTabController, animated: true)
           }
        }
    }
    
    func updateAction(action: UIAlertAction){
        print("se cambió el pedido")
    }
    
    func OpenChat(){
        self.performSegue(withIdentifier: Constants.Storyboard.segueChat, sender: self)
        
    }
    
    
    @IBAction func btnOpenChat(_ sender: RoundButton) {
        OpenChat()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
        
          if segue.identifier ==  Constants.Storyboard.segueChat{
            let notif = appDelegate.responseNotification
            var varPedido: String? = nil
            varPedido = notif?[idPedido] as? String
            if (varPedido == nil){
                if (pedidoActivo != nil){
                    varPedido = String(pedidoActivo!)
                }
            }
            
            let ChatController = segue.destination as! MessageChatViewController
            ChatController.orderId = Int(varPedido!)
           
          }
      
     }
    
    // ********************************************************************************************************************
    
    @IBAction func btnCancel(_ sender: RoundButton) {
        
        self.cardViewController.token = cliente?.token!
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if (varPedido == nil){
            varPedido = pedidoActivo
        }
        
        if varPedido != nil {

            self.cardViewController.orderId = Int(varPedido!)
            self.cardViewController.loadData(_pOrder: Int(varPedido!)!, _pCliente: (cliente?.token!)!, _pCancelReasons: cancelReasons)
                      
                        // muestra el card view
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        }
      
                  
        
    }
    func returnMainViewController(){
                   let controllers = self.navigationController?.viewControllers
                    for vc in controllers! {
                      if vc is MainTabController {
                        _ = self.navigationController?.popToViewController(vc as! MainTabController, animated: true)
                      }
                   }
    }
    func sendData(data : Response?, message: String) {
        self.responseCancel = data
        self.reason = message
           
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
        self.returnMainViewController()
       
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        //self.view.addSubview(visualEffectView)
        
        cardViewController = CancelOrderViewController(nibName:"CancelOrderViewController", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
    
        
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight+100)
        
        cardViewController.view.clipsToBounds = true
        
        
        cardViewController.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))

        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)

        
        self.cardViewController.token = cliente?.token!
        
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if (varPedido == nil){
            if (pedidoActivo != nil){
                varPedido = String(pedidoActivo!)
            }
        }
        
        if varPedido != nil {

            self.cardViewController.orderId = Int(varPedido!)
        }
        //self.cardViewController.orderId = order!.id
        print("En success get cancel reason \(self.cliente!)")
        RequestManager.fetchCancelReason(oauthToken: self.cliente!.token! , success: { response in
        
                    print("En success get cancel reason \(response)")
                    self.cancelReasons = response
         
            })
            { error in
               debugPrint("---ERROR---")
            }
        
        
    }
    
     @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            //blurAnimator.startAnimation()
            //runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    //*********************************************************************************************************************
    
    func getDataOrder(){
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        if varPedido != nil {
            getPedido(pidPedido: varPedido!)
            
        }else{
            if (pedidoActivo != nil){
                self.getPedido(pidPedido: pedidoActivo!)
            }
        }
    }
    
    func getPedido(pidPedido: String) {
    
        
        let fbToken = appDelegate.FBToken
        print("Token FB : \(fbToken)")
           
        RequestManager.getOrderData(oauthToken: cliente!.token!, idPedido: pidPedido, success: { response in
            self.txtDireccion.text = "\(response.direccion!)"
            self.txtPrecio.text = "\(response.monto)"
            self.txtCantidad.text = "\(response.cantidad)"
            self.txtFormaPago.text = "\(response.formaPago!)"
            self.txtTiempo.text = "\(response.tiempo!)"
            self.txtDistancia.text = "\(response.distancia!)"
            self.txtCliente.text = "\(response.nombreCliente!)"
            self.txtStatus.text = "\(response.nombreStatus!)"
            self.txtPedido.text = "\(response.id)"
            
            self.stringDireccion = response.direccion!
            self.location =  CLLocationCoordinate2D(latitude: response.latitud, longitude: response.longitud)
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
        
        //Defining destination
        let latitude: CLLocationDegrees = (self.location!.latitude)
        let longitude: CLLocationDegrees = (self.location!.longitude)

        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.stringDireccion
        mapItem.openInMaps(launchOptions: options)

        
        
      /*if let UrlNavigation = URL.init(string: "comgooglemaps://") {
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
      }*/
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
    
    

    func closeToViewController(){
        let controllers = self.navigationController?.viewControllers
         for vc in controllers! {
           if vc is MainTabController {
             _ = self.navigationController?.popToViewController(vc as! MainTabController, animated: true)
           }
        }
    }
    @IBAction func openWaze(_ sender: RoundButton) {
        //let location =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            // Waze is installed. Launch Waze and start navigation
            let urlStr: String = "waze://?ll=\(location!.latitude),\(location!.longitude)&navigate=yes"
            UIApplication.shared.openURL(URL(string: urlStr)!)
        }
        else {
            // Waze is not installed. Launch AppStore to install Waze app
            UIApplication.shared.openURL(URL(string: "http://itunes.apple.com/us/app/id323229106")!)
        }
    }
    
    
    
    
    @IBAction func btnProcessOrder(_ sender: RoundButton) {
        var varStatus: String? = "2" // aceptado
        switch sender.currentTitle
        {
            case "Cargar":
                varStatus = "5"
                self.btnCancel.isEnabled = false
                //self.txtStatus.text = "Cargando Pedido ..."
                //sender.setTitle("Finalizar Carga",for: .normal)
            case "Finalizar Carga":
                varStatus = "6"
                //self.txtStatus.text = "Carga Finalizada"
                //sender.setTitle("Cobrar",for: .normal)
            case "Cobrar":
                varStatus = "7"
                //self.txtStatus.text = "Pedido Cobrado"
                //sender.setTitle("Finalizar Pedido",for: .normal)
            case "Finalizar Pedido":
                varStatus = "8"
                //self.txtStatus.text = "Pedido Finalizado"
                //sender.setTitle("Pedido Finalizado",for: .normal)
             default:
                varStatus = "0"
                break
        }
        
        ChangeStatusOrder(pStatus: varStatus!)
        
        
    }
    
    func ChangeStatusOrder(pStatus: String) {
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if (varPedido == nil){
            if (pedidoActivo != nil){
                varPedido = String(pedidoActivo!)
            }
        }
           
        RequestManager.ChangeStatusOrder(oauthToken: cliente!.token!, parameters: [WSKeys.parameters.pedido: varPedido ?? 0,WSKeys.parameters.status: pStatus], success: { response in
                        
            debugPrint("En success requestorder \(response.codeError)")
            switch self.btnProcessOrder.currentTitle
            {
                case "Cargar":
                    self.txtStatus.text = "Cargando Pedido ..."
                    self.btnProcessOrder.setTitle("Finalizar Carga",for: .normal)
                case "Finalizar Carga":
                    self.txtStatus.text = "Carga Finalizada"
                    self.btnProcessOrder.setTitle("Cobrar",for: .normal)
                case "Cobrar":
                    self.txtStatus.text = "Pedido Cobrado"
                    self.btnProcessOrder.setTitle("Finalizar Pedido",for: .normal)
                case "Finalizar Pedido":
                    self.txtStatus.text = "Pedido Finalizado"
                    self.btnProcessOrder.setTitle("Pedido Finalizado",for: .normal)
                    self.closeToViewController()
                 default:
                    self.txtStatus.text = "Error!!!"
                    break
            }
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
                
    }
}
