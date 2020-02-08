//
//  perfilViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 21/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
struct Perfil {

    var id : Int
    var title : String
    var text : String

}
class perfilViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
   
    @IBOutlet weak var tableView: UITableView!
    
    let PerfilesData = [
        Perfil(id: 1, title: "Sexo", text: "Masculino"),
        Perfil(id: 2, title: "Fecha de Nacimiento", text: "10 Julio 1984"),
        Perfil(id: 3, title: "Teléfono", text: "(722) 261 9771"),
        Perfil(id: 4, title: "Correo Electrónico", text: "nexus.gsan@gmail.com"),

    ]
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
           // Do any additional setup after loading the view.
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return PerfilesData.count
       }

       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "PerfilDetalleViewCell", for: indexPath)

           // Configure the cell...
        let Perfil = PerfilesData[indexPath.row]
        cell.textLabel?.text = Perfil.title
        cell.detailTextLabel?.text = Perfil.text
           
           return cell
       }
    
}
