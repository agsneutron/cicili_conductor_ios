//
//  perfilViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 21/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
struct Direccion {

    var id : Int
    var title : String
    var text : String

}
class SupplementaryDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!

    let DireccionesData = [
        Direccion(id: 1, title: "Documentos", text: "Listado de documentos"),
        Direccion(id: 2, title: "Cuentas", text: "configuracion de cuenta"),
        Direccion(id: 3, title: "Pipas", text: "Información de la pipa"),

    ]
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
           // Do any additional setup after loading the view.
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return DireccionesData.count
       }

       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "DireccionDetalleViewCell", for: indexPath)

           // Configure the cell...
        let Direccion = DireccionesData[indexPath.row]
        cell.textLabel?.text = Direccion.title
        cell.detailTextLabel?.text = Direccion.text
           
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: Constants.Storyboard.documentsSegue, sender: self)
        case 1:
            self.performSegue(withIdentifier: Constants.Storyboard.accountSegue, sender: self)
        default:
            self.performSegue(withIdentifier: Constants.Storyboard.tankTruckSegue, sender: self)
        }
       
        
    }
}
