//
//  TankTruckViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 21/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class TankTruckViewController: UIViewController {

    @IBOutlet weak var lblPipa: UILabel!
    
    @IBOutlet weak var lblPlanta: UILabel!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblMunicipio: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblCaducidad: UILabel!
    @IBOutlet weak var lblPlacas: UILabel!
    @IBOutlet weak var lblModelo: UILabel!
    @IBOutlet weak var lblMarca: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        getTankTruckData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))

        // Do any additional setup after loading the view.
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
       navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getTankTruckData(){
        RequestManager.getTankTruck(oauthToken: self.cliente!.token!, success: { response in

            self.lblPipa.text = "Pipa: \(response.facturaContenedor!)"
            self.txtColor.text = response.color
            self.lblEstado.text = "Estado: \(response.nombreEstado!)"
            self.lblMunicipio.text = "Municipio: \(response.nombreMunicipio!)"
            self.lblRegion.text = "Región: \(response.region!)"
            self.lblCaducidad.text = "Caducidad: \(response.caducidad!)"
            self.lblPlacas.text = "Placas: \(response.placa!)"
            self.lblModelo.text = "Modelo: \(response.modelo!)"
            self.lblMarca.text = "Marca: \(response.marca!)"
            self.lblPlanta.text = "Planta: \(response.planta!)"
            })
            { error in
               debugPrint("---ERROR---")
            }
    }

    
    @IBAction func updateColorTankTruck(_ sender: RoundButton) {
        RequestManager.updateColorTankTruck(oauthToken: self.cliente!.token!, parameters: [WSKeys.parameters.pColor: self.txtColor.text!], success: { response in
                                    
                    debugPrint("En success setUpdateCoordinate \(response)")
            self.handleCancel()
                        
            })
            { error in
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
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
