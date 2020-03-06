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
    
    
    
    //cancel cardview
    enum CardState {
        case expanded
        case collapsed
    }
    
    //var cardViewController
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
    //endvar card view
    
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
        
        
        
        setupCard()
       
    }
    

    @IBAction func btnOrder(_ sender: RoundButton) {
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: RoundButton) {
            
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
        
        
        //cardViewController.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))
    
        let tapGestureRecognizerBtn = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))
        let panGestureRecognizerBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        //btnMasCercano.addGestureRecognizer(tapGestureRecognizerBtn)
        //btnMasCercano.addGestureRecognizer(panGestureRecognizerBtn)
        
        btnCancel.addGestureRecognizer(tapGestureRecognizerBtn)
        btnCancel.addGestureRecognizer(panGestureRecognizerBtn)
        
        self.cardViewController.token = cliente?.token
        self.cardViewController.orderId = order!.id
        RequestManager.fetchCancelReason(oauthToken: self.cliente!.token! , success: { response in
        
                    print("En success get cancel reason \(response)")
                    self.cardViewController.cancelReasons = response
         
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
