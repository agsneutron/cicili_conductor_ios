//
//  DetallePedidosViewController.swift
//  cicili_cliente
//
//  Created by guillermo sanchez on 29/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
struct Pedidos {
    
    var id : Int
    var title : String
    var direccion : String
    var fecha : String
    var litros : String
    var precio : String
    
}


class DetallePedidoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let PedidosesData = [
        Pedidos(id: 1, title: "Casa", direccion: "Unidad victoria rebeca 119", fecha: "12/03/2020", litros: "120", precio: "$1230.00"),
        Pedidos(id: 2, title: "Trabajo", direccion: "Cerrada san antonio 11", fecha: "12/03/2020", litros: "20", precio: "$130.00"),
        Pedidos(id: 3, title: "Negocio", direccion: "Catalpas 1018 el castaño", fecha: "12/03/2020", litros: "520", precio: "$12230.00"),
        Pedidos(id: 4, title: "Casa campo", direccion: "Pedro velez 989 sauces", fecha: "12/03/2020", litros: "820", precio: "$9230.00"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PedidosesData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "PedidosDetalleViewCell", for: indexPath)
        let cell: PedidoHistoricoTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PedidosDetalleViewCell") as! PedidoHistoricoTableViewCell
        
        // Configure the cell...
        let Pedidos = PedidosesData[indexPath.row]
        // cell.textLabel?.text = Pedidos.title
        //cell.detailTextLabel?.text = Pedidos.text
        cell.tituloPedidoDetalle?.text = Pedidos.title
        cell.direccionLabel?.text = Pedidos.direccion
        cell.fechaLabel?.text = Pedidos.fecha
        cell.litrosLabel?.text = Pedidos.litros
        cell.precioLabel?.text = Pedidos.precio
        
        return cell
    }
    
}
