//
//  BoardViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 21/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewBoard: UITableView!
    @IBOutlet weak var pickerWeeks: UIPickerView!
    var weeksArray : [ReusableIdText] = []
    var boardDataArray : [NewOrder] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    
    var selectedWeek: Int = 1
    var sWeek : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerWeeks.delegate = self
        pickerWeeks.dataSource = self
        tableViewBoard.delegate = self
        tableViewBoard.dataSource = self
        self.cliente = appDelegate.responseCliente
        
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
            view.addGestureRecognizer(gesture)
            let texto = ReusableIdText()
            texto.id=0
            texto.text = "Selecciona una semana"
        
        weeksArray = [texto]
        self.getWeeks()
        self.getBoardData()

        // Do any additional setup after loading the view.
    }
    
    func getWeeks(){
        RequestManager.getWeeks(oauthToken: self.cliente!.token! , success: { response in
            self.weeksArray = response
            self.pickerWeeks.reloadAllComponents()
            
            })
            { error in
               debugPrint("---ERROR---")
            }
    }
    
    func getBoardData(){
        RequestManager.getBoardData(oauthToken: self.cliente!.token!, idWeek: String(selectedWeek) , success: { response in
            self.boardDataArray = response
            self.tableViewBoard.reloadData()
            
            })
            { error in
               debugPrint("---ERROR---")
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weeksArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weeksArray[row].text
    }
    //setpicker selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        selectedWeek = weeksArray[row].id
        self.sWeek = weeksArray[row].text
        self.getBoardData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("boardDataArray.count: \(boardDataArray.count)")
        return boardDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: BoardTableViewCell = self.tableViewBoard.dequeueReusableCell(withIdentifier: "BoardTableViewCell") as! BoardTableViewCell
        
        
        let object = boardDataArray[indexPath.row]
        cell.lblDia?.text = "Día: \(object.fechaSolicitada!)"
        cell.lblPipa?.text = "Pipa: \(object.numeroPipa!)"
        FunctionsApp.currencyFormat(tipAmount : NSNumber(value: object.monto), txtObject : cell.lblMonto, etiqueta: "")
        FunctionsApp.decimalFormat(tipAmount : NSNumber(value: object.cantidad), txtObject : cell.lblLitros, etiqueta: "Litros: ")
        //cell.lblMonto?.text = "$ \(object.monto)"
        //cell.lblLitros?.text = "Litros: \(object.cantidad)"
        cell.lblPlacas?.text = "Placas: \(object.placa!)"
        cell.lblPlanta?.text = "\(object.planta!)"
        cell.lblConductor?.text = "Conductor: \(object.nombreConductor!)"
        
        return cell
    }

    
}
