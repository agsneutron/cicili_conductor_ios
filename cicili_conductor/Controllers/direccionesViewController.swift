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
class direccionesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!

    let DireccionesData = [
        Direccion(id: 1, title: "Casa", text: "Unidad victoria rebeca 119"),
        Direccion(id: 2, title: "Trabajo", text: "Cerrada san antonio 11"),
        Direccion(id: 3, title: "Negocio", text: "Catalpas 1018 el castaño"),
        Direccion(id: 4, title: "Casa campo", text: "PEdro velez 989 sauces"),

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
    
}
