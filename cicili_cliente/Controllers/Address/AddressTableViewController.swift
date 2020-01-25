//
//  AddressTableViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 15/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol AddressTableDelegate {
    func addAddress(address: AddressTable)
}

class AddressTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var searchAddress = [AddressTable]()
    var searching = false
    
    var delegate: AddressTableDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tblAddressView: UITableView!
    var addressArray = [AddressTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        
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
        if searching {
            return searchAddress.count
        }else {
            return addressArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AddressTableViewCell")
        }
        
        if searching {
            cell?.textLabel?.text = searchAddress[indexPath.row].name
        }else {
            cell?.textLabel?.text = addressArray[indexPath.row].name
        }
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
        //closeAddressTable()
        delegate?.addAddress(address: addressArray[(tblAddressView.indexPathForSelectedRow?.row)!])
        tblAddressView.deselectRow(at: tblAddressView.indexPathForSelectedRow!, animated: true)
        handleCancel()
        
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
    
   // MARK: - Selectors
    
    @objc func handleDone() {
        
        /*guard let fullname = textField.text, textField.hasText else {
            print("Handle error here..")
            return
        }
        
        let contact = Contact(fullname: fullname)
        
        delegate?.addContact(contact: contact)*/
    }
    
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

extension AddressTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAddress = addressArray.filter({$0.name.prefix(searchText.count) == searchText})
        searching = true
        tblAddressView.reloadData()
    }
}
