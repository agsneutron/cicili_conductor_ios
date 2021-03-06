//
//  AddressTableViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 10/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

//class AddressTableViewController: UITableViewController {
class AddressTableCardViewController: UITableViewController {
    var addresses = [AddressTable]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AddressTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddressTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AddressTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let address = addresses[indexPath.row]
        
        cell.nameLabel.text = address.name
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func loadAddress() {
        
        guard let address1 = AddressTable(id: 1, name: "Casa") else {
            fatalError("Unable to instantiate meal1")
        }

        guard let address2 = AddressTable(id: 2, name: "Trabajo") else {
            fatalError("Unable to instantiate meal2")
        }

        guard let address3 = AddressTable(id: 3, name: "Casa papás") else {
            fatalError("Unable to instantiate meal2")
        }

        addresses += [address1, address2, address3]
    }

}
