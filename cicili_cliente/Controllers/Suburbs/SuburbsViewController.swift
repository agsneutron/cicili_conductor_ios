//
//  SuburbsViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 17/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

protocol SuburbsTableDelegate {
    func addSuburb(suburb: SuburbsTable)
}

class SuburbsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var searchSuburb = [SuburbsTable]()
    var searching = false
    
    var suburbsJSON : DataByZipCode?
    
    var delegate: SuburbsTableDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tblSuburbView: UITableView!
    var suburbsArray = [SuburbsTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        
        loadSuburbs()
        
        
        tblSuburbView.dataSource = self
        tblSuburbView.delegate = self
        
        

    }
    
    func loadSuburbs(){
        // Do any additional setup after loading the view, typically from a nib.
        /*guard let suburb1 = SuburbsTable(id: 1, name: "José Maria Morelos") else {
            fatalError("Unable to instantiate meal1")
        }

        guard let suburb2 = SuburbsTable(id: 2, name: "Juan FErnandez Albarran") else {
            fatalError("Unable to instantiate meal2")
        }

        guard let suburb3 = SuburbsTable(id: 3, name: "La pilita") else {
            fatalError("Unable to instantiate meal2")
        }
        
        suburbsArray += [suburb1, suburb2, suburb3]
        */
        for suburbItem in suburbsJSON!.asentamientos!{
            
                suburbsArray.append(SuburbsTable(id: suburbItem.id, name: suburbItem.text!)!)
        }
    }
    //MARK:- UITableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchSuburb.count
        }else {
            return suburbsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SuburbsTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SuburbsTableViewCell")
        }
        
        if searching {
            cell?.textLabel?.text = searchSuburb[indexPath.row].name
        }else {
            cell?.textLabel?.text = suburbsArray[indexPath.row].name
        }
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
        //closeAddressTable()
        delegate?.addSuburb(suburb: suburbsArray[(tblSuburbView.indexPathForSelectedRow?.row)!])
        tblSuburbView.deselectRow(at: tblSuburbView.indexPathForSelectedRow!, animated: true)
        handleCancel()
        
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
    }

}

extension SuburbsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSuburb = suburbsArray.filter({$0.name.prefix(searchText.count) == searchText})
        searching = true
        tblSuburbView.reloadData()
    }
}
