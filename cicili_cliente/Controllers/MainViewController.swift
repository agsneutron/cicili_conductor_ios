//
//  MainViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import MapKit


class MainViewController: UIViewController, AddressTableDelegate, AvailableDriversDelegate {
    
    var addresRequest: AddressTable?
    
    @IBOutlet weak var MapView: MKMapView!
    
    var cliente: Cliente?

    @IBOutlet weak var TxtAddress: UILabel!
    @IBOutlet weak var TxtDriver: UILabel!
    
    @IBOutlet weak var TxtBienvenida: UILabel!
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    //var cardViewController:CardMapViewController!
    var cardViewController:CardMapViewController!
    var visualEffectView:UIVisualEffectView!
    
    
    
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 0
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        // Do any additional setup after loading the view.
    
        RequestManager.fetchClientStatus(oauthToken: self.cliente!.token! , success: { response in
            if let statusUpdated = response.status, !statusUpdated.isEmpty{
                print("En success status updated \(statusUpdated)")
                switch statusUpdated {
                              case WSKeys.parameters.completo:
                                debugPrint("STATUS IN C SWITCH")
                                debugPrint(statusUpdated)
                                self.setupCard()
                                  
                              case WSKeys.parameters.datos_personales:
                                 /* guard let personalController = self.storyboard?.instantiateViewController(
                                  withIdentifier: "PersonalDataStoryboard") as? PersonalDataViewController else {
                                          fatalError("Unable to create PersonalDataController")
                                      }
                                              
                                    personalController.cliente = self.self.cliente
                                  self.present(personalController, animated: true, completion: nil)*/
                                             
                                  self.performSegue(withIdentifier: Constants.Storyboard.personalDataSegueId, sender: self)
                              case WSKeys.parameters.datos_pago:
                                  guard let paymentController = self.storyboard?.instantiateViewController(
                                  withIdentifier: "PaymentDataStoryboard") as? PaymentDataViewController else {
                                          fatalError("Unable to create PaymentDataController")
                                      }
                                  paymentController.cliente = self.cliente
                                  self.present(paymentController, animated: true, completion: nil)
                                              
                                  // self.performSegue(withIdentifier: Constants.Storyboard.paymentDataSegueId, sender: self)
                              case WSKeys.parameters.datos_direccion:
                                              
                                  guard let addressController = self.storyboard?.instantiateViewController(
                                  withIdentifier: "AddressDataStoryboard") as? AddressDataViewController else {
                                          fatalError("Unable to create PaymentDataController")
                                      }
                                  debugPrint("frommaintodir")
                                  debugPrint(self.cliente?.token)
                                  addressController.cliente = self.cliente
                                  self.present(addressController, animated: true, completion: nil)
                                  //self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)
                              case WSKeys.parameters.verifica_codigo:
                                          
                                  guard let verifyCodeController = self.storyboard?.instantiateViewController(
                                  withIdentifier: "VerifyStoryboard") as? VerifyCodeViewController else {
                                              fatalError("Unable to create VerifyCodeController")
                                              }
                                verifyCodeController.token = self.cliente!.token
                                  self.present(verifyCodeController, animated: true, completion: nil)
                                  //self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)
                          
                              default:
                
                                    debugPrint("VC MAIN switch default")
                                  self.showAlertController(tittle_t: Constants.ErrorTittles.tittleStatus, message_t: Constants.ErrorMessages.messageStatus)
                      
                                  guard let loginController = self.storyboard?.instantiateViewController(
                                  withIdentifier: "LoginStoryboard") as? ViewController else {
                                  fatalError("Unable to create LoginViewController")
                                  }
                              
                                  self.present(loginController, animated: true, completion: nil)
                              }
            }
        })
        { error in
           debugPrint("---ERROR---")
        }
        
        TxtBienvenida.text = " ¡ Hola \(cliente!.nombre!) ! "
              
    
    }
    

     func addAddress(address: AddressTable) {
         self.TxtAddress.text=address.name
     }
    
    func addAvailableDrivers(drivers: AvailableDrivers) {
    self.TxtDriver.text=drivers.name
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        //self.view.addSubview(visualEffectView)
        
        cardViewController = CardMapViewController(nibName:"CardMapViewController", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
    
   
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
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

    
    @IBAction func showPipasTable(_ sender: UIButton) {
        //self.performSegue(withIdentifier: Constants.Storyboard.presentAddresTable, sender: self)
    
        /*let controller = AddressTableViewController()
        controller.delegate = self
    
        
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)*/
    let driversView = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDriversID") as! AvailableDriversViewController
    driversView.delegate=self
    self.navigationController?.pushViewController(driversView, animated: true)
        
    }
    
    
    
    @IBAction func showAddressTable(_ sender: UIButton) {
        let addressView = self.storyboard?.instantiateViewController(withIdentifier: "AddressTableID") as! AddressTableViewController
        addressView.delegate=self
        addressView.cliente = self.cliente
        self.navigationController?.pushViewController(addressView, animated: true)
    }
    /*@IBAction func showAddressTableXib(_ sender: Any) {
    
    animateTransitionIfNeeded(state: nextState, duration: 0.9)
    
    }*/
    /*@IBAction func showBSheet(_ sender: UIButton) {
        let viewController: MainViewController = MainViewController()
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet, animated: true, completion: nil)
    }*/
}


/*extension MainViewController: AddressTableDelegate {
    
    func addAddress(address: AddressTable) {
        //self.dismiss(animated: true) {
            //self.contacts.append(contact)
            //self.tableView.reloadData()
    
        //}
        self.TxtAddress.text=address.name
    }
}*/
