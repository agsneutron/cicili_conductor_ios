//
//  AcceptOrderViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import UIKit
import AVFoundation

class AcceptOrderViewController: UIViewController, DataCancelDelegate {

    var audioPlayer = AVAudioPlayer()

    var cliente: Cliente?

    var order: NewOrder?
    var message: String?
    var cancelReasons: [ReusableIdText] = []
    var responseCancel: Response?
    var reason: String?
    
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet  var txtDriver: UILabel!
    @IBOutlet  var txtStatus: UILabel!
    
    @IBOutlet var txtQuantity: UILabel!
    @IBOutlet var txtPayment: UILabel!
    @IBOutlet var txtHour: UILabel!
    @IBOutlet var txtDate: UILabel!
    @IBOutlet var txtAmount: UILabel!
    
    @IBOutlet weak var requestedOrder: UIView!
    
    let indexStatus = "status"
   
    
    let idPedido = "idPedido"
    let pstatus = "status"
    let pQuantity = "quantity"
    let pPayment = "payment"
    let pHour = "hour"
    let pDate = "date"
    let pAmount = "amount"

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
    var pedidoActivoStatus: String? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "alert",ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        }
        catch{
            print(error)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.cliente = appDelegate.responseCliente
        
        setupCard()
        /*navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))*/

        // Do any additional setup after loading the view.
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        print("varPedido ",varPedido)
        if varPedido != nil {

            self.getPedido(pidPedido: varPedido!)
        }else{
            if (pedidoActivo != nil){
                if (pedidoActivoStatus != "1"){

                    self.performSegue(withIdentifier: Constants.Storyboard.segueAcceptOrder, sender: self)
                }
                self.getPedido(pidPedido: String(pedidoActivo!))
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationCancelOrder(notification:)), name: Notification.Name("NotificationCancelOrder"), object: nil)

    }
                
    @objc func NotificationCancelOrder(notification: Notification){
                    print("Leego notificacion")
                    let notif = appDelegate.responseNotification
                    var varStatus: String? = nil
                    varStatus = notif?[indexStatus] as? String
                    
                   if (varStatus == "3"){
                      self.customAlertController(tittle_t: Constants.AlertTittles.titleOrderCanceled, message_t: Constants.AlertMessages.messageOrderCanceled, buttonAction: Constants.textAction.actionOK, doHandler: self.closeViewController)
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
    
    func returnMainViewController(){
                   let controllers = self.navigationController?.viewControllers
                    for vc in controllers! {
                      if vc is MainTabController {
                        _ = self.navigationController?.popToViewController(vc as! MainTabController, animated: true)
                      }
                   }
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // ********************************************************************************************************************
    
    @IBAction func btnCancel(_ sender: RoundButton) {
        
        self.cardViewController.token = cliente?.token!
        let notif = appDelegate.responseNotification
        var varPedido: String? = nil
        varPedido = notif?[idPedido] as? String
        
        if (varPedido == nil){
            varPedido = String(pedidoActivo!)
        }
        
        if varPedido != nil {

            self.cardViewController.orderId = Int(varPedido!)
            self.cardViewController.loadData(_pOrder: Int(varPedido!)!, _pCliente: (cliente?.token!)!, _pCancelReasons: cancelReasons)
                      
                        // muestra el card view
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
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
        print("varPedido ",varPedido)
        if varPedido != nil {
            self.cardViewController.orderId = Int(varPedido!)
        }else{
            if (pedidoActivo != nil){
                self.cardViewController.orderId = Int(pedidoActivo!)
            }
        }
        //self.cardViewController.orderId = order!.id
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
    
    func getPedido(pidPedido: String) {
    
        
        let fbToken = appDelegate.FBToken
        print("Token FB : \(fbToken)")
           
        RequestManager.getOrderData(oauthToken: cliente!.token!, idPedido: pidPedido, success: { response in
                        
            debugPrint("En success requestorder \(response.direccion!)")
            
            self.txtTitle.text = "\(response.id)"
            self.txtStatus.text = "\(response.nombreStatus!) "
            self.txtDate.text = "\(response.fechaSolicitada!)"
            self.txtHour.text = "\(response.horaSolicitada!) "
            self.txtPayment.text = "\(response.formaPago!) "
            self.txtQuantity.text = "\(response.cantidad)"
            self.txtAmount.text = "\(response.precio) "
            
            
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
        
        if (varPedido == nil){
            if (pedidoActivo != nil){
                varPedido = String(pedidoActivo!)
            }
        }
           
        RequestManager.acceptOrder(oauthToken: cliente!.token!, parameters: [WSKeys.parameters.pedido: varPedido ?? 0], success: { response in
            self.audioPlayer.stop()
            debugPrint("En success requestorder \(response.codeError)")
            self.performSegue(withIdentifier: Constants.Storyboard.segueAcceptOrder, sender: self)
            
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier ==  Constants.Storyboard.segueAcceptOrder {
            let newOrderController = segue.destination as! RequestedOrderViewController
            if self.pedidoActivo != nil{
                newOrderController.pedidoActivo = self.pedidoActivo
            }
            
        }
    }
    

}
