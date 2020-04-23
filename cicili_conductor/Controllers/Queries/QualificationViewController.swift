//
//  QualificationViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 18/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class QualificationViewController: UIViewController {
    var currentUserId = Auth.auth().currentUser?.uid
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?

    
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var totalCalificacion: UILabel!
    @IBOutlet weak var totalCompletados: UILabel!
    var arrImageViews = [UIImageView]()
    var imageView: UIImageView!
    var intRate: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.cliente = appDelegate.responseCliente
        self.getQualifications()
        //self.setUpStarStack()
        // Do any additional setup after loading the view.
    }
    

    func getQualifications() {
        
        RequestManager.getQualifications(oauthToken: cliente!.token!, success: { response in
                            
            debugPrint("En success getQualifications \(response.calificacion)")
            self.totalCalificacion.text = "\(response.calificacion)"
            self.totalCompletados.text = "\(response.completados)"
            self.setStarFill(val: response.calificacion)
            })
            { error in
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
            }
                
    }
    
    func setUpStarStack() {
        starStackView.axis = NSLayoutConstraint.Axis.horizontal
        starStackView.distribution = .fillEqually
        starStackView.alignment = .fill
        starStackView.spacing = 30
        starStackView.tag = 5007
        
        for i in 0..<5{
            imageView = UIImageView()
            if (i == 0){
                imageView.tag = 5009
            }
            imageView.image = UIImage(named: "icon_star")
            starStackView.addArrangedSubview(imageView)
            arrImageViews.append(imageView)
        }
        //starStackView.translatesAutoresizingMaskIntoConstraints = false
                
    }
    
    func setStarFill(val: Int) {
        starStackView.axis = NSLayoutConstraint.Axis.horizontal
        starStackView.distribution = .fillEqually
        starStackView.alignment = .fill
        starStackView.spacing = 30
        starStackView.tag = 5007
        
        for i in 0..<5{
            imageView = UIImageView()
            if (i == 0){
                imageView.tag = 5009
            }
            if (i < val){
                imageView.image = UIImage(named: "icon_star_fill")
            }else{
                imageView.image = UIImage(named: "icon_star")
            }
            starStackView.addArrangedSubview(imageView)
            arrImageViews.append(imageView)
        }
        //starStackView.translatesAutoresizingMaskIntoConstraints = false
                
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first
        let location = touchLocation?.location(in: starStackView)
        if (touchLocation?.view?.tag == 5007){
            var intRating: Int = 0
            arrImageViews.forEach ({ (imageView) in
                if ((location?.x)! > imageView.frame.origin.x){
                    let i = arrImageViews.firstIndex(of: imageView)
                    intRating = i! + 1
                    intRate = Int(intRating)
                    print("rating : \(intRate)")
                    imageView.image = UIImage(named: "icon_star_fill")
                }else{
                    if (imageView.tag != 5009){
                        imageView.image =  UIImage(named: "icon_star")
                    }
                }
                
            })
        }*/
    }
    
    
    
    
    @IBAction func showComments(_ sender: RoundButton) {
        
        //self.performSegue(withIdentifier: Constants.Storyboard.segueComments, sender: self)
        RequestManager.getComments(oauthToken: cliente!.token!, success: { response in
             
            let addressView = self.storyboard?.instantiateViewController(withIdentifier: "DetailCommentsID") as! DetailCommentsViewController
            //addressView.delegate=self
            //addressView.cliente = self.cliente
            addressView.commentsObject = response
            //self.addressObject = response
            self.navigationController?.pushViewController(addressView, animated: true)
            
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
        
    }
    
    
}
