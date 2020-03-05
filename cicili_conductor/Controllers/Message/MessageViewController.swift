//
//  MessageViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente : Cliente?
    var claimData: ClaimConsult?
    var getMessage = [Message]()
    
    @IBOutlet weak var imgClient: UIImageView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var tblMessages: UITableView!
    
    @IBOutlet weak var textFieldMessage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        /*  1 claim
            2 ask
            3 chat
        */
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        
              
             
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)

        imgClient.layer.masksToBounds = true
        imgClient.layer.cornerRadius = imgClient.bounds.width / 2
        imgClient.layer.borderColor = UIColor.white.cgColor
        imgClient.layer.borderWidth = 2
        imgClient.image = base64ToImage(cliente!.imagen!)
               
        
        // Do any additional setup after loading the view.
        lblFirst.text = "Cliente: \(String(describing: cliente!.nombre!))"
        lblSecond.text = "Categoria: \(String(describing: claimData!.tipoAclaracion!.text!))"
        if claimData!.idPedido == 0 {

           self.navigationItem.title = "Seguimiento a Pregunta"
            lblThird.text = "Pregunta: \(String(describing: claimData!.aclaracion!))"
            
        }else if claimData!.idPedido != 0 {
            self.navigationItem.title = "Seguimiento a Aclaración"
            lblThird.text = "Aclaración: \(String(describing: claimData!.aclaracion!))"
            
        }else{
            
        }
        
       
        tblMessages.dataSource = self
        tblMessages.delegate = self
        tblMessages.rowHeight = UITableView.automaticDimension
        tblMessages.estimatedRowHeight = 600
        
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
           guard let imageData = Data(base64Encoded: base64String) else { return nil }
           return UIImage(data: imageData)
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         loadData()
    }
   
    func loadData(){
        //load data if exists
               RequestManager.fetchMessages(oauthToken: self.cliente!.token!, id: "\(claimData!.id)", success: { response in
                                       
                   if response.count > 0 {
                                         //                       print("En success getclaim for order response \(response)")
                        debugPrint("---------SEGUIMIENTO--------")
                       debugPrint(response)
                       //for msg in response{
                       //    self.getMessage.append(msg)
                       //}
                       self.getMessage = response
                      self.tblMessages.reloadData()
                    let indexPath = NSIndexPath(row: self.getMessage.count-1, section: 0)
                    self.tblMessages.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                       //self.performSegue(withIdentifier: Constants.Storyboard.messageSegueId, sender: self)
                      // debugPrint(response)
                   }
                   else{
                      // self.performSegue(withIdentifier: Constants.Storyboard.toAskSegueId, sender: self)
                   }
               })
               { error in
                   self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica,message_t: error.localizedDescription)
               }
    }
    
    

    @IBAction func btnSend(_ sender: UIButton) {
        
        if let newMsg = textFieldMessage.text, !newMsg.isEmpty{
            
            let msgData = NewMessage()
            msgData.aclaracion = claimData!.id
            msgData.texto = newMsg
              
                  
            let objectAsDict:[String : AnyObject] = Mapper<NewMessage>().toJSON(msgData) as [String : AnyObject]
            RequestManager.setMessage(oauthToken: cliente!.token!, parameters: objectAsDict , success: { response in
                  
                debugPrint("En success requestorder \(response)")
                
                self.getMessage = response
                self.tblMessages.reloadData()
                let indexPath = NSIndexPath(row: self.getMessage.count-1, section: 0)
                self.tblMessages.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
            })
            { error in
                debugPrint("---ERROR setOrderData---")
                 self.showAlertController(tittle_t: Constants.ErrorTittles.titleErrorMsg, message_t: error.localizedDescription)
                      
                //self.delegate?.sendData(data: nil, message: self.messageerror)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */@objc func handleCancel() {
      navigationController?.popViewController(animated: true)
      navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
            return getMessage.count
        }
        
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
       
        
        cell.txtText.text = getMessage[indexPath.row].texto!
        cell.txtUser.text = getMessage[indexPath.row].usuario!
        cell.txtTime.text = "\(getMessage[indexPath.row].fecha!)"

        return cell
    }

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
        //closeAddressTable()
        
       // selectedCategory = getMessage[(tblMessages.indexPathForSelectedRow?.row)!]
        
        tblMessages.deselectRow(at: tblMessages.indexPathForSelectedRow!, animated: true)
        
        
    }


}
