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
    
    var arrImageViews = [UIImageView]()
    var imageView: UIImageView!
    var intRate: Int = 0
    var counter: Int = 0
    var idPedido: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        
        
        for comment in commentsObject!{
            //print("En comment \(comment)")
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
    
    func setUpStarStack(cell: CommentsTableViewCell, calificacion: Int) {
        
        var intRating: Int = 0
        cell.arrImageViews.forEach ({ (imageView) in
            
            let i = cell.arrImageViews.firstIndex(of: imageView)
            if i! < calificacion {
                imageView.image = UIImage(named: "icon_star_fill")
            }else{
                imageView.image =  UIImage(named: "icon_star")
            }
            
        })
        
        
                
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
        cell.lblCliente?.text = "\(comments.nombreCliente!)"
        cell.lblPedido?.text = "\(comments.idPedido)"
        cell.lblFecha?.text = "\(comments.fecha!)"
        cell.lblComentarios?.text = "Comentario: \(comments.comentario!)"
        cell.lblCalificacion?.text = "Calificación: \(comments.calificacion)"

        setUpStarStack(cell: cell, calificacion: comments.calificacion)
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let comments = commentsArray[indexPath.row]
        idPedido = String(comments.idPedido)
        self.performSegue(withIdentifier: Constants.Storyboard.segueOrderDetail, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier ==  Constants.Storyboard.segueOrderDetail{
            let newController = segue.destination as! OrderDetailViewController
            
            newController.idPedido = idPedido
            newController.historic = "N"
            
        }
    
    }
}
