//
//  ContratoEspecificoViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 29/05/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import PDFKit


@available(iOS 11.0, *)
class ContratoEspecificoViewController: UIViewController {


    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        self.downloadFile()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func downloadFile(){
        self.progressBar.progress = 0
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("Contrato.pdf")
            return (documentsURL, [.removePreviousFile])
        }
        

        Alamofire.download(Router.getSpecificContract(autorizathionToken: self.cliente!.token!, parametersSet: ["id": String(self.cliente!.idCliente)], pType: "pdf", pContenttype:"application/pdf"), to: destination).downloadProgress(closure: { (progress) in
        
        self.progressBar.progress = Float(progress.fractionCompleted)
            
        }).response { response in
            print("response.error \(response.error)")
            if let pdfURL = response.destinationURL {
                    
                    DispatchQueue.main.async{
                        // Instantiate PDFDocument
                        if #available(iOS 11.0, *) {
                            print("pdfURL \(pdfURL)")
                            let pdfDoc = PDFDocument(url: pdfURL)
                            self.pdfView.document = pdfDoc
                        } else {
                            // Fallback on earlier versions
                        }
                        

                    }
            }
            
            if let destinationUrl = response.destinationURL {
                print("destinationUrl \(destinationUrl.absoluteURL)")
                self.showAlertController(tittle_t: Constants.AlertTittles.downloadFile, message_t: Constants.AlertMessages.messageDownloadFile)
            }else{
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleErrorDownloadFile, message_t: Constants.ErrorMessages.messageDownloadFile)
            }
        }
    }

}
