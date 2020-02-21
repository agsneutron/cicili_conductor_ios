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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
