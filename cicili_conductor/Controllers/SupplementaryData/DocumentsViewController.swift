//
//  DocumentsViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 21/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    var documentsDataArray : [DocumentsData] = []
    
    @IBOutlet weak var documentsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        documentsTable.dataSource = self
        documentsTable.delegate = self
        getDocumentsData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))

        // Do any additional setup after loading the view.
    }
    
    func getDocumentsData(){
        RequestManager.getDocumentsData(oauthToken: self.cliente!.token!, idConductor: String(self.cliente!.idCliente), success: { response in
            self.documentsDataArray = response
            self.documentsTable.reloadData()
             debugPrint("---\(response)---")
            })
            { error in
               debugPrint("---ERROR---")
            }
    }
    
    func closeToViewController(){
        let controllers = self.navigationController?.viewControllers
        debugPrint("controllers ... ")
         for vc in controllers! {
            debugPrint("controllers: \(vc)")
        }
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
       navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentsDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: DocumentsTableViewCell = self.documentsTable.dequeueReusableCell(withIdentifier: "DocumentsTableViewCell") as! DocumentsTableViewCell
        
        
        let object = documentsDataArray[indexPath.row]
        cell.lblDocument?.text = "\(object.nombreTipo!)"
        cell.lblStatus?.text = "\(object.nombreStatus!)"
        cell.lblFileName?.text = "\(object.archivo!)"
        
        return cell
    }
}
