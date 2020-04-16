////  ViewController.swift//  cicili_cliente////  Created by ARIANA SANCHEZ on 17/12/19.//  Copyright © 2019 CICILI. All rights reserved.//import UIKitimport QuartzCoreimport FirebaseAuthimport FirebaseDatabaseclass ViewController: UIViewController {    @IBOutlet weak var userTextField: UITextField!    @IBOutlet weak var passwordTextField: UITextField!        var responseCliente: Cliente?    var varToken: String?    let appDelegate = UIApplication.shared.delegate as! AppDelegate    let iToken = "token"    var hashTableToken : [AnyHashable: Any]?        override func viewDidLoad() {        super.viewDidLoad()            NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationResponseFCMToken(notification:)), name: Notification.Name("sendToken"), object: nil)              navigationController?.setNavigationBarHidden(true, animated: true)        // Do any additional setup after loading the view, typically from a nib.                userTextField.becomeFirstResponder()        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))        view.addGestureRecognizer(gesture)    }        @objc func NotificationResponseFCMToken(notification: Notification){        //let delegate = appDelegate.responseNotification        //let pUserInfo = notification.userInfo        print("entro a la  NotificationResponseFCMToken")        debugPrint("entro a la  NotificationResponseFCMToken")            }        @IBAction func singIn(_ sender: UIButton) {            self.view.endEditing(true)        self.hashTableToken = appDelegate.responseToken        //let fbToken = self.hashTableToken![iToken]        let fbToken = appDelegate.FBToken        print("Token FB : \(fbToken!)")            if let username = userTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty {                                   RequestManager.fetchSignIn(parameters: [WSKeys.parameters.PUSERNAME: username, WSKeys.parameters.PPASSWORD: password, WSKeys.parameters.PTOKENDISPOSITIVO: fbToken!], success: { response in                                if response.token != nil{                    print("En success y token no nil \(response)")                    self.appDelegate.responseCliente = response                    self.authInFirebase()                    self.userTextField.text = ""                    self.passwordTextField.text = ""                    self.responseCliente = response                                             // self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")                                     switch response.status {                        case WSKeys.parameters.completo:                            debugPrint("VC- Login C \(String(describing: response.status))")                            self.performSegue(withIdentifier: Constants.Storyboard.homeSegueId, sender: self)                                           /* guard let personalController = self.storyboard?.instantiateViewController(                                            withIdentifier: "MainStoryboard") as? PersonalDataViewController else {                                            fatalError("Unable to create PersonalDataController")                                        }                                        mainController.cliente = response                                        self.present(mainController, animated: true, completion: nil)*/                                    case WSKeys.parameters.datos_personales:                                        guard let personalController = self.storyboard?.instantiateViewController(                                            withIdentifier: "PersonalDataStoryboard") as? PersonalDataViewController else {                                            fatalError("Unable to create PersonalDataController")                                        }                                                                                personalController.cliente = response                                        self.present(personalController, animated: true, completion: nil)                                                                              // self.performSegue(withIdentifier: Constants.Storyboard.personalDataSegueId, sender: self)                                    case WSKeys.parameters.datos_pago:                                        guard let paymentController = self.storyboard?.instantiateViewController(                                             withIdentifier: "PaymentDataStoryboard") as? PaymentDataViewController else {                                             fatalError("Unable to create PaymentDataController")                                         }                                         paymentController.cliente = response                                         self.present(paymentController, animated: true, completion: nil)                                                                                // self.performSegue(withIdentifier: Constants.Storyboard.paymentDataSegueId, sender: self)                                    case WSKeys.parameters.datos_direccion:                                                                               /* guard let addressController = self.storyboard?.instantiateViewController(                                            withIdentifier: "AddressDataStoryboard") as? AddressDataViewController else {                                            fatalError("Unable to create PaymentDataViewController")                                        }                                        addressController.cliente = response                                        self.present(addressController, animated: true, completion: nil)*/                                                                                self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)                                    case WSKeys.parameters.verifica_codigo:                                                                            guard let verifyCodeController = self.storyboard?.instantiateViewController(                                        withIdentifier: "VerifyStoryboard") as? VerifyCodeViewController else {                                        fatalError("Unable to create VerifyCodeController")                                        }                                        verifyCodeController.token = response.token                                        self.present(verifyCodeController, animated: true, completion: nil)                                    //self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)                                                        default:                                        debugPrint("----MainVC in default switch")                                        self.showAlertController(tittle_t: Constants.ErrorTittles.tittleStatus, message_t: Constants.ErrorMessages.messageStatus)                                    }                    //let vc = self.storyboard?.    (withIdentifier: "MainStoryboard")                    //self.present(vc!, animated: true, completion: nil)                                        }                })                { error in                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)                }                    } else {            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)        }    }        @IBAction func forgotPassword(_ sender: UIButton) {                self.performSegue(withIdentifier: Constants.Storyboard.passwordSegueId, sender: self)        }        @IBAction func registerClient(_ sender: UIButton) {                self.performSegue(withIdentifier: Constants.Storyboard.verifyCodeSegue, sender: self)               }        // navigation    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        // Get the new view controller using segue.destination.        // Pass the selected object to the new view controller.           if segue.identifier == Constants.Storyboard.homeSegueId{                let mainTab = segue.destination as! UITabBarController            let mainVC = mainTab.viewControllers!.first as! MainViewController            //let displayVC = segue.destination as! MainViewController            mainVC.cliente = self.responseCliente        }        if segue.identifier ==  Constants.Storyboard.adressDataSegueId{            let addressController = segue.destination as! AddressDataViewController            addressController.cliente = self.responseCliente        }    }            func authInFirebase() {        print("Entro authInFirebase ")            if let email = userTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty {            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in                    let adCliente = self.appDelegate.responseCliente                    if error == nil {                        print("Entro authInFirebase signIn ")                        if let user = user?.user {                            print("Entro authInFirebase let user = user?.user ")                            let userData = ["provider": user.providerID, USER_IS_DRIVER: true, ACCOUNT_PICKUP_MODE_ENABLED: true, DRIVER_IS_ON_TRIP: true, CICILI_DRIVER_KEY: adCliente?.idCliente] as [String: Any]                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)                        }                    } else {                            if let errorCode = AuthErrorCode(rawValue: error!._code){                            switch errorCode {                            case .wrongPassword:                                self.showAlert(message: ERROR_MSG_WRONG_PASSWORD)                            default:                                self.showAlert(message: ERROR_MSG_UNEXPECTED_ERROR)                            }                        }                                                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in                            if error != nil {                                print("Entro authInFirebase crear usuario ")                            if let errorCode = AuthErrorCode(rawValue: error!._code) {                                    switch errorCode {                                    case .invalidEmail:                                        self.showAlert(message: ERROR_MSG_INVALID_EMAIL)                                    default:                                        self.showAlert(message: ERROR_MSG_UNEXPECTED_ERROR)                                    }                                }                            } else {                                if let user = user?.user {                                        let userData = ["provider": user.providerID, USER_IS_DRIVER: true, ACCOUNT_PICKUP_MODE_ENABLED: true, DRIVER_IS_ON_TRIP: true, CICILI_DRIVER_KEY: adCliente?.idCliente] as [String: Any]                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)                                }                            }                        })                    }                })        }    }}