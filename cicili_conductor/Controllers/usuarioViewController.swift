//
//  usuarioViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 17/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class usuarioViewController: UIViewController {
    @IBOutlet weak var perfilView: UIView!
    @IBOutlet weak var direccionesView: UIView!
    @IBOutlet weak var circularImage: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente : Cliente?
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        self.cliente = appDelegate.responseCliente
        lblUserName.text = "\(String(describing: cliente!.nombre!)) \(String(describing: cliente!.apellidoPaterno!)) \( String(describing: cliente!.apellidoMaterno!))"
        
        circularImage.layer.masksToBounds = true
        circularImage.layer.cornerRadius = circularImage.bounds.width / 2
        circularImage.layer.borderColor = UIColor.white.cgColor
        circularImage.layer.borderWidth = 5
        circularImage.image = base64ToImage(cliente!.imagen!)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
       }

    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            perfilView.alpha = 0
            direccionesView.alpha = 1
        } else {
            perfilView.alpha = 1
            direccionesView.alpha = 0
        }
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

extension usuarioViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil {
        self.circularImage.image = image
            
    
        let imageSelected = circularImage.image
        let imageEncoded = imageSelected!.jpegData(compressionQuality: 0.50)!.base64EncodedString()
        self.appDelegate.responseCliente?.imagen = imageEncoded
              
          let personal = Personal()
        
            personal.nombre = cliente?.nombre
            personal.apellidoPaterno = cliente?.apellidoPaterno
            personal.apellidoMaterno = cliente?.apellidoMaterno
            personal.sexo = cliente?.sexo
            personal.nacimiento = cliente?.nacimiento
            personal.imagen = imageEncoded
            personal.user = cliente?.correoElectronico
        
            let objectAsDict:[String : AnyObject] = Mapper<Personal>().toJSON(personal) as [String : AnyObject]

            RequestManager.setPersonalData(oauthToken: cliente!.token!, parameters: objectAsDict, success: { response in
                
                if response.codeError == WSKeys.parameters.okresponse{
                    print("En success update image\(response)")
                    self.showAlertController(tittle_t: Constants.AlertTittles.tChangeSuccess, message_t: Constants.AlertMessages.messageSuccess)
                    self.appDelegate.responseCliente?.imagen = imageEncoded
                    //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                    
                    }
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
        }
        
    }
}
