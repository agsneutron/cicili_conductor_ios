//
//  AccountUpdateViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 28/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class AccountUpdateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    @IBOutlet weak var picckerBank: UIPickerView!
    @IBOutlet weak var txtAccountNumber: UITextField!
    
    var banksArray : [ReusableIdText] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    
    var selectedBank: Int = 1
    var sBank : String?
    var accountNumber: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picckerBank.delegate = self
        picckerBank.dataSource = self
        self.txtAccountNumber.text = self.accountNumber
        self.cliente = appDelegate.responseCliente
        self.getWeeks()
        navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Regresar", style: .plain, target: self, action: #selector(handleCancel))

            // Do any additional setup after loading the view.
        }
        
        @objc func handleCancel() {
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)

        }
    
    func getWeeks(){
        RequestManager.getBanks(oauthToken: self.cliente!.token! , success: { response in
            self.banksArray = response
            self.picckerBank.reloadAllComponents()
            
            })
            { error in
               debugPrint("---ERROR---")
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return banksArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return banksArray[row].text
    }
    //setpicker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        selectedBank = banksArray[row].id
        self.sBank = banksArray[row].text

    }


    @IBAction func btnUpdateAccount(_ sender: RoundButton) {
        
    }
    
}
