//
//  CardMapViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class CardMapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var handleArea: UIView!
    
    
    @IBOutlet weak var tblAddressView: UITableView!
    var addressArray = [AddressTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let address1 = AddressTable(name: "Casa") else {
            fatalError("Unable to instantiate meal1")
        }

        guard let address2 = AddressTable(name: "Trabajo") else {
            fatalError("Unable to instantiate meal2")
        }

        guard let address3 = AddressTable(name: "Casa papás") else {
            fatalError("Unable to instantiate meal2")
        }
        
        addressArray += [address1, address2, address3]
        
        tblAddressView.dataSource = self
        tblAddressView.delegate = self

    }
    
    
    //MARK:- UITableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "productstable")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "productstable")
        }
        
        cell?.textLabel?.text = addressArray[indexPath.row].name
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainViewController {
            destination.addresRequest = addressArray[(tblAddressView.indexPathForSelectedRow?.row)!]
            tblAddressView.deselectRow(at: tblAddressView.indexPathForSelectedRow!, animated: true)

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
