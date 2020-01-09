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

    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var sexPicker: UIPickerView!
    @IBOutlet weak var bornDatePicker: UIDatePicker!
    @IBOutlet weak var secondLastnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var pickerData: [String] = [String]()
    var selectedSexPicker :Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.becomeFirstResponder()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
        // Connect data:
        sexPicker.delegate = self as! UIPickerViewDelegate
        sexPicker.dataSource = self as! UIPickerViewDataSource
        
        //set data to sex picker
        pickerData = ["Selecciona una opción", "Hombre","Mujer","No indicar"]
    }
    
    @IBAction func personalDataRegisterButton(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if let name = nameTextField.text, !name.isEmpty, let lastname = lastnameTextField.text, !lastname.isEmpty, let secondlastname = secondLastnameTextField.text, !secondlastname.isEmpty {
            
            var personal = Personal()
        
            personal.nombre = name
            personal.apellidoPaterno = lastname
            personal.apellidoMaterno = secondlastname
        
            let _:String = Mapper().toJSONString(personal, prettyPrint: true)!
            let objectAsDict:[String : AnyObject] = Mapper<Personal>().toJSON(personal) as [String : AnyObject]

            RequestManager.setPersonalData(parameters: objectAsDict, success: { response in
                
                if response != nil{
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
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedSexPicker = row
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
