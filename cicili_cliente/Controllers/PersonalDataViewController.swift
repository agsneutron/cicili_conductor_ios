//
//  PersonalDataViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class PersonalDataViewController: UIViewController {
    //, UIPickerViewDelegate, UIPickerViewDataSource
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var perfilImage: UIImageView!
    //@IBOutlet weak var sexPicker: UIPickerView!
    @IBOutlet weak var bornDatePicker: UIDatePicker!
    @IBOutlet weak var secondLastnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    //var pickerData: [String] = [String]()
    var selectedGenderPicker :String = ""
   
    var cliente: Cliente?
    let dateFormatter = DateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
        // Connect data:
        //set data to sex picker
        //pickerData = ["Selecciona una opción", "Hombre","Mujer","No indicar"]
        //self.sexPicker.dataSource = self
        //self.sexPicker.delegate = self
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        //debugPrint("ON PERSONALDATA......")
        //debugPrint(cliente?.correoElectronico)
    }
    
    @IBAction func personalDataRegisterButton(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let imageSelected = perfilImage.image
        let imageEncoded = imageSelected!.jpegData(compressionQuality: 1)!.base64EncodedString()
        
        switch genderSegment.selectedSegmentIndex
           {
           case 0:
            selectedGenderPicker = WSKeys.parameters.hombre
           case 1:
               selectedGenderPicker = WSKeys.parameters.mujer
            case 2:
            selectedGenderPicker = WSKeys.parameters.noindicar
           default:
               break
           }
        
        if let nameInput = nameTextField.text, !nameInput.isEmpty, !selectedGenderPicker.isEmpty, let lastnameInput = lastnameTextField.text, !lastnameInput.isEmpty, let secondlastnameInput = secondLastnameTextField.text, !secondlastnameInput.isEmpty, !imageEncoded.isEmpty {
            
            let personal = Personal()
        
            personal.nombre = nameInput
            personal.apellidoPaterno = lastnameInput
            personal.apellidoMaterno = secondlastnameInput
            personal.sexo = selectedGenderPicker
            personal.nacimiento = dateFormatter.string(from: bornDatePicker.date)
            personal.imagen = imageEncoded
            personal.user = cliente?.correoElectronico
        
            let _:String = Mapper().toJSONString(personal, prettyPrint: true)!
            let objectAsDict:[String : AnyObject] = Mapper<Personal>().toJSON(personal) as [String : AnyObject]

            RequestManager.setPersonalData(oauthToken: cliente!.token!, parameters: objectAsDict, success: { response in
                
                if response.codeError == WSKeys.parameters.okresponse{
                    print("En success \(response)")
                    self.nameTextField.text = ""
                    self.lastnameTextField.text = ""
                    //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                    self.present(vc!, animated: true, completion: nil)
                    
                    }
                })
                { error in
                    self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
                }
        } else {
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleRequerido, message_t: Constants.ErrorMessages.messageRequeridoLogin)
        }
    }
    
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    //sexpicker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        //selectedGenderPicker = pickerData[row]
    }
 
 */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

   
}
