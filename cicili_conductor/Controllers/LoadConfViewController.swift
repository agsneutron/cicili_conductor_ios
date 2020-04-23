//
//  LoadConfViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 22/04/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class LoadConfViewController: UIViewController {

    var responseCliente: Cliente?
    var varToken: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //LocalStorage
    struct defaultsKeys {
        static let keyOne = "userStringKey"
        static let keyTwo = "passStringKey"
    }
    var varUser: String?
    var varPass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationResponseFCMToken(notification:)), name: Notification.Name("sendToken"), object: nil)
      
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func NotificationResponseFCMToken(notification: Notification){

        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne){
            varUser = stringOne
            varPass = defaults.string(forKey: defaultsKeys.keyTwo)
            self.fSingIn()
        }else{
            self.performSegue(withIdentifier: Constants.Storyboard.segueToLogin, sender: self)
        }
        
    }
    
    func fSingIn(){
        self.view.endEditing(true)
            //let fbToken = self.hashTableToken![iToken]
            let fbToken = appDelegate.FBToken
            print("Token FB : \(fbToken!)")
        
            if let username = varUser, !username.isEmpty, let password = varPass, !password.isEmpty {
                
               
                RequestManager.fetchSignIn(parameters: [WSKeys.parameters.PUSERNAME: username, WSKeys.parameters.PPASSWORD: password, WSKeys.parameters.PTOKENDISPOSITIVO: fbToken!], success: { response in
                    
                    if response.token != nil{
                        print("En success y token no nil \(response)")
                        self.appDelegate.responseCliente = response
                        //self.authInFirebase()
                        self.responseCliente = response
        
                 
                        
          
                       // self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                       
                      switch response.status {
                            case WSKeys.parameters.completo:
                                debugPrint("VC- Login C \(String(describing: response.status))")
                                self.performSegue(withIdentifier: Constants.Storyboard.segueToMainTab, sender: self)

                           
                        
                                        default:
                                            debugPrint("----MainVC in default switch")
                                            self.showAlertController(tittle_t: Constants.ErrorTittles.tittleStatus, message_t: Constants.ErrorMessages.messageStatus)
                                        }

                        
                        }
                    })
                    { error in
                        self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                    }
                
            } else {
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
            }
    }
    
}
