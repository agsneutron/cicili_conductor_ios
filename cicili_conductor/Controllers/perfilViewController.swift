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
    
    
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   var cliente : Cliente?
    
    @IBOutlet weak var tableView: UITableView!
    
    var PerfilesData = [
        Perfil(id: 1, title: "Sexo", text: ""),
        Perfil(id: 2, title: "Fecha de Nacimiento", text: ""),
        Perfil(id: 3, title: "Teléfono", text: ""),
        Perfil(id: 4, title: "Correo Electrónico", text: ""),

    ]
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.cliente = appDelegate.responseCliente
        PerfilesData = [
            Perfil(id: 1, title: "Sexo", text: cliente!.sexo!),
               Perfil(id: 2, title: "Fecha de Nacimiento", text: cliente!.nacimiento!),
               Perfil(id: 3, title: "Teléfono", text: cliente!.telefono!),
               Perfil(id: 4, title: "Correo Electrónico", text: cliente!.correoElectronico!),

           ]
        
        tableView.reloadData()
           // Do any additional setup after loading the view.
       }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
       self.cliente = appDelegate.responseCliente
        PerfilesData = [
            Perfil(id: 1, title: "Sexo", text: cliente!.sexo!),
               Perfil(id: 2, title: "Fecha de Nacimiento", text: cliente!.nacimiento!),
               Perfil(id: 3, title: "Teléfono", text: cliente!.telefono!),
               Perfil(id: 4, title: "Correo Electrónico", text: cliente!.correoElectronico!),

           ]
        
        tableView.reloadData()
     
     
        
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
    
    @IBAction func btnEditPersonalData(_ sender: RoundButton) {
        self.performSegue(withIdentifier: Constants.Storyboard.editPersonalSegueId, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              // Get the new view controller using segue.destination.
              // Pass the selected object to the new view controller.
         
        if segue.identifier ==  Constants.Storyboard.editPersonalSegueId{
               let editPersonalViewController = segue.destination as! PersonalDataViewController
               editPersonalViewController.cliente = self.cliente
               editPersonalViewController.mode = 1
               
               
           }
          }
    
}
