//
//  ViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 17/12/19.
//  Copyright © 2019 CICILI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
        
        userTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    
    @IBAction func singIn(_ sender: UIButton) {
    
        self.view.endEditing(true)
        
        if let username = userTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty {
            RequestManager.fetchSignIn(parameters: [WSKeys.parameters.PUSERNAME: username, WSKeys.parameters.PPASSWORD: password, WSKeys.parameters.PTOKENDISPOSITIVO: "1234"], success: { response in
                
                if response.token != nil{
                    print("En success y token no nil \(response.token)")
                    self.userTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                    //self.present(vc!, animated: true, completion: nil)
                    
                    }
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
        } else {
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
        }
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
       
       
       
        self.performSegue(withIdentifier: Constants.Storyboard.passwordSegueId, sender: self)
       
    }
    
    @IBAction func registerClient(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: Constants.Storyboard.registerSegueId, sender: self)
           
    }
    
    

}

