//
//  MainHelpViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class MainHelpViewController: UIViewController {

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente : Cliente?
    var getAsk : ClaimConsult?
    @IBOutlet weak var faqview: UIView!
    @IBOutlet weak var legalview: UIView!
    @IBOutlet weak var segmentHelpLegal: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
          

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changueView(_ sender: UISegmentedControl) {
    
        if sender.selectedSegmentIndex == 0 {
            legalview.alpha = 0
            faqview.alpha = 1
        } else {
            legalview.alpha = 1
            faqview.alpha = 0
        }
    }
    
    
    @IBAction func addQuestion(_ sender: Any) {
        
        RequestManager.fetchAsk(oauthToken: self.cliente!.token!, success: { response in
                                
            if response.count > 0 {
                                  //                       print("En success getclaim for order response \(response)")
                debugPrint(response)
                for ask in response{
                    self.getAsk = ask
                }
                self.performSegue(withIdentifier: Constants.Storyboard.messageSegueId, sender: self)
                debugPrint(response)
            }
            else{
                self.performSegue(withIdentifier: Constants.Storyboard.toAskSegueId, sender: self)
            }
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
               if segue.identifier ==  Constants.Storyboard.messageSegueId{
                 let messageViewController = segue.destination as! MessageViewController
                  messageViewController.claimData = getAsk
                
                 
                 
             }
             else if segue.identifier ==  Constants.Storyboard.toAskSegueId{
               let claimOrderController = segue.destination as! AskViewController
                claimOrderController.order = 0
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
