//
//  AvailableDriversViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 16/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

protocol AvailableDriversDelegate {
    func addAvailableDrivers(drivers: AvailableDrivers)
}

class AvailableDriversViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    var delegate: AvailableDriversDelegate?
     
     @IBOutlet weak var tblAvailableDriversView: UITableView!
     var driversArray = [AvailableDrivers]()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
         //view.backgroundColor = .white
         navigationController?.setNavigationBarHidden(false, animated: true)
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
         
         
         
         // Do any additional setup after loading the view, typically from a nib.
        guard let driver1 = AvailableDrivers(id: 1,name: "Armando Contreras Vargas - Zgas") else {
             fatalError("Unable to instantiate meal1")
         }

         guard let driver2 = AvailableDrivers(id: 2,name: "Federico Esparragoza Tristan - Imperial") else {
             fatalError("Unable to instantiate meal2")
         }

         guard let driver3 = AvailableDrivers(id: 3,name: "Fernando Díaz Barrientos - Gaserito") else {
             fatalError("Unable to instantiate meal2")
         }
         
         driversArray += [driver1, driver2, driver3]
         
         tblAvailableDriversView.dataSource = self
         tblAvailableDriversView.delegate = self
         
         

     }
     
     
     //MARK:- UITableView methods
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return driversArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = tableView.dequeueReusableCell(withIdentifier: "productstable")
         if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productstable")
         }
         
         cell?.textLabel?.text = driversArray[indexPath.row].name
         return cell!
     }

     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
         //closeAddressTable()
         delegate?.addAvailableDrivers(drivers: driversArray[(tblAvailableDriversView.indexPathForSelectedRow?.row)!])
         tblAvailableDriversView.deselectRow(at: tblAvailableDriversView.indexPathForSelectedRow!, animated: true)
         handleCancel()
         
     }
     
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
     
    // MARK: - Selectors
     
     @objc func handleAdd() {
         
         /*guard let fullname = textField.text, textField.hasText else {
             print("Handle error here..")
             return
         }
         
         let contact = Contact(fullname: fullname)
         
         delegate?.addContact(contact: contact)*/
     }
     
     @objc func handleCancel() {
         //self.dismiss(animated: true, completion: nil)
         navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
     }

}
