//
//  FAQTableViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class FAQTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblCategoryView: UITableView!
    var getToken: String?
    var categoryArray = [ReusableIdText]()
    var selectedCategory : ReusableIdText?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente : Cliente?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
              
        self.navigationItem.title = "Categorías"
           
           
        tblCategoryView.dataSource = self
        tblCategoryView.delegate = self
           
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         loadCategory()
    }
    
    func loadCategory(){
        categoryArray.removeAll()
        RequestManager.fetchFAQ(oauthToken: self.cliente!.token!, success: { response in
                                       
                   if response.count > 0 {
                                         //                       print("En success getclaim for order response \(response)")
                       debugPrint(response)
                       for ctg in response{
                        self.categoryArray.append(ctg)
                        
                       }
                    
                       self.tblCategoryView.reloadData()
                       debugPrint(response)
                   }
                   else{
                      
                   }
               })
               { error in
                   self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
               }
    }
    // MARK: - Table view data source

    /* func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

   
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
            return categoryArray.count
        }
        
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FAQTableViewCell")
        }
        
        
        cell?.textLabel?.text = categoryArray[indexPath.row].text!
      
        return cell!
    }

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
        //closeAddressTable()
        
        selectedCategory = categoryArray[(tblCategoryView.indexPathForSelectedRow?.row)!]
        
        tblCategoryView.deselectRow(at: tblCategoryView.indexPathForSelectedRow!, animated: true)
        
         self.performSegue(withIdentifier: Constants.Storyboard.tofaqdetailSegueId, sender: self)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier ==  Constants.Storyboard.tofaqdetailSegueId{
            let FDontroller = segue.destination as! FAQDetailViewController
            FDontroller.token = self.cliente?.token!
            FDontroller.selectedCategory = self.selectedCategory
                    
        }
           
       }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
