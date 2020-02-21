//
//  HistoricalTableViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 20/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
class HistoricalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    
    var historicalArray = [HistoricalTable]()
    @IBOutlet weak var tableViewHistorical: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cliente = appDelegate.responseCliente
         self.getHistorical()
        tableViewHistorical.dataSource = self
        tableViewHistorical.delegate = self
        tableViewHistorical.reloadData()
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - get historical orders
    
    func getHistorical() {
        
        RequestManager.getHistorical(oauthToken: cliente!.token!, success: { response in
            
            var direccion: String = ""
            for object in response{
                if (object.direccion != nil){
                    direccion = object.direccion!
                }
                self.historicalArray.append(HistoricalTable(horaSolicitada: object.horaSolicitada!,fechaSolicitada: object.fechaSolicitada!,monto: object.monto,formaPago: object.formaPago!,direccion: direccion,nombreStatus: object.nombreStatus!)!)
            }
            self.tableViewHistorical.reloadData()
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
        
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: HistoricalTableViewCell = self.tableViewHistorical.dequeueReusableCell(withIdentifier: "HistoricalTableViewCell") as! HistoricalTableViewCell
        
        
        let object = historicalArray[indexPath.row]
        cell.hora?.text = "\(object.horaSolicitada!)"
        cell.monto?.text = "$ \(object.monto)"
        cell.fecha?.text = "\(object.fechaSolicitada!)"
        cell.formaPago?.text = "\(object.formaPago!)"
        cell.direccion?.text = "\(object.direccion!)"
        cell.status?.text = "\(object.nombreStatus!)"
        
        return cell
    }
    
    

}
