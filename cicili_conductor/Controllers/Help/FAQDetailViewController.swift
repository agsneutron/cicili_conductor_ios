//
//  FAQDetailViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class FAQDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tblCategoryView: UITableView!
    var token: String?
    var categoryArray = [FAQ]()
    var selectedCategory : ReusableIdText?
    var selectedFAQ : FAQ?
    override func viewDidLoad() {
         super.viewDidLoad()
        self.navigationItem.title = selectedCategory?.text!
        self.navigationItem.backBarButtonItem?.title = "Regresar"
        tblCategoryView.dataSource = self
        tblCategoryView.delegate = self
        
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        RequestManager.fetchFAQList(oauthToken: self.token!, id: "\(selectedCategory!.id)", success: { response in
                                            
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
             var cell = tableView.dequeueReusableCell(withIdentifier: "FAQDetailTableViewCell")
             if cell == nil {
                 cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FAQDetailTableViewCell")
             }
             
             
             cell?.textLabel?.text = categoryArray[indexPath.row].pregunta!
           
             return cell!
         }

         
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
             //closeAddressTable()
             
             selectedFAQ = categoryArray[(tblCategoryView.indexPathForSelectedRow?.row)!]
             
             tblCategoryView.deselectRow(at: tblCategoryView.indexPathForSelectedRow!, animated: true)
            
            self.showAlertController(tittle_t: selectedFAQ!.pregunta!, message_t: selectedFAQ!.respuesta!)
             
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
