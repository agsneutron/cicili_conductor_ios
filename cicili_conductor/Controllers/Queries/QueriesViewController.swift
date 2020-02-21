//
//  QuerysViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 18/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class QueriesViewController: UIViewController {

    @IBOutlet weak var qualificationView: UIView!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var historicalView: UIView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    var historicalArray = [HistoricalTable]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        //getHistorical()
    
        // Do any additional setup after loading the view.
    }
    

    func getHistorical() {
        
        RequestManager.getHistorical(oauthToken: cliente!.token!, success: { response in
            print(" response.count : \(response.count)")
            var i: Int = 0
            var direccion: String = ""
            for object in response{
                i = i+1
                if (object.direccion != nil){
                    direccion = object.direccion!
                }
                //print(" object : \(i) ID: \(object.direccion!)")
                self.historicalArray.append(HistoricalTable(horaSolicitada: object.horaSolicitada!,fechaSolicitada: object.fechaSolicitada!,monto: object.monto,formaPago: object.formaPago!,direccion: direccion,nombreStatus: object.nombreStatus!)!)
            }
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
        
    }
    
    @IBAction func queriesSwitch(_ sender: UISegmentedControl) {
        print("Segmento: \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex {
        case 0:
            qualificationView.alpha = 1
            boardView.alpha = 0
            historicalView.alpha = 0
        case 1:
            qualificationView.alpha = 0
            boardView.alpha = 1
            historicalView.alpha = 0
        default:
            qualificationView.alpha = 0
            boardView.alpha = 0
            historicalView.alpha = 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  Constants.Storyboard.historicalSegue{
            let newOrderController = segue.destination as! HistoricalTableViewController
            newOrderController.historicalArray = self.historicalArray
            
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
