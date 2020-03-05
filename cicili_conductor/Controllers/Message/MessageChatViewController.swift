//
//  File.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import ObjectMapper

class MessageChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 var cliente : Cliente?
 var orderId: Int?
 var getMessage = [Message]()
 let indexStatus = "status"
 @IBOutlet weak var imgClient: UIImageView!
 @IBOutlet weak var lblFirst: UILabel!

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
     lblFirst.text = "\(String(describing: cliente!.nombre!))"
    self.navigationItem.title = "Seguimiento a Pedido"
     
     
    
     tblMessages.dataSource = self
     tblMessages.delegate = self
     tblMessages.rowHeight = UITableView.automaticDimension
     tblMessages.estimatedRowHeight = 600
    
     NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationChat(notification:)), name: Notification.Name("NotificationChat"), object: nil)

     }
     
     @objc func NotificationChat(notification: Notification){
         print("Leego notificacion")
         let notif = appDelegate.responseNotification
         var varStatus: String? = nil
         varStatus = notif?[indexStatus] as? String
         
        if (varStatus == "20"){
            viewDidAppear(true)
        }
        if (varStatus == "3"){
           self.customAlertController(tittle_t: Constants.AlertTittles.titleOrderCanceled, message_t: Constants.AlertMessages.messageOrderCanceled, buttonAction: Constants.textAction.actionOK, doHandler: self.closeViewController)
        }
     }
 
    
    func closeViewController(action: UIAlertAction){
        let controllers = self.navigationController?.viewControllers
         for vc in controllers! {
           if vc is MainTabController {
             _ = self.navigationController?.popToViewController(vc as! MainTabController, animated: true)
           }
        }
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
    RequestManager.fetchChatMessages(oauthToken: self.cliente!.token!, id: "\(String(describing: orderId!))", success: { response in
                                    
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
         
         let msgData = NewChatMessage()
         msgData.idPedido = orderId!
         msgData.mensaje = newMsg
           
               
         let objectAsDict:[String : AnyObject] = Mapper<NewChatMessage>().toJSON(msgData) as [String : AnyObject]
         RequestManager.setChatMessage(oauthToken: cliente!.token!, parameters: objectAsDict , success: { response in
               
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
     let cell: MessageChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageChatTableViewCell
    
    if (getMessage.count>0){
         cell.txtText.text = getMessage[indexPath.row].mensaje!
         cell.txtUser.text = getMessage[indexPath.row].usuario!
         cell.txtTime.text = "\(getMessage[indexPath.row].fecha!)"
    }
     return cell
 }

 
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //performSegue(withIdentifier: "presentMainFromAddress", sender: self)
     //closeAddressTable()
     
    // selectedCategory = getMessage[(tblMessages.indexPathForSelectedRow?.row)!]
     
     tblMessages.deselectRow(at: tblMessages.indexPathForSelectedRow!, animated: true)
     
     
 }


}
