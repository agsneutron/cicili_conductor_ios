//
//  DetailCommentsViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 19/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class DetailCommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var commentsObject : [CommentsData]?
    var commentsArray = [CommentsTable]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        
        
        for comment in commentsObject!{
            print("En comment \(comment)")
            self.commentsArray.append(CommentsTable(idPedido: comment.idPedido,fecha: comment.fecha!,calificacion: comment.calificacion,comentario: comment.comentario!,nombreCliente: comment.nombreCliente!)!)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
       navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "PedidosDetalleViewCell", for: indexPath)
        let cell: CommentsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DetailCommentsViewCell") as! CommentsTableViewCell
        
        // Configure the cell...
        let comments = commentsArray[indexPath.row]
        cell.lblCliente?.text = "Cliente: \(comments.nombreCliente!)"
        cell.lblPedido?.text = "Pedido: \(comments.idPedido)"
        cell.lblFecha?.text = "Fecha: \(comments.fecha!)"
        cell.lblComentarios?.text = "Comentario: \(comments.comentario!)"
        cell.lblCalificacion?.text = "Calificación: \(comments.calificacion)"
        
        
        return cell
    }
    
}
