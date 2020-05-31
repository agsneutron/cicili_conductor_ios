//
//  ContratoGenericoViewController.swift
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
class ContratoGenericoViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        // Do any additional setup after loading the view.
        self.downloadFile()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func downloadFile(){
            self.progressBar.progress = 0
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                documentsURL.appendPathComponent("ContratoGenerico.pdf")
                return (documentsURL, [.removePreviousFile])
            }
            

            Alamofire.download(Router.getGenericContract(pContenttype:"application/pdf"), to: destination).downloadProgress(closure: { (progress) in
            
            self.progressBar.progress = Float(progress.fractionCompleted)
                
            }).response { response in
                if let pdfURL = response.destinationURL {
                        
                        DispatchQueue.main.async{
                            // Instantiate PDFDocument
                            if #available(iOS 11.0, *) {
                                let pdfDoc = PDFDocument(url: pdfURL)
                                self.pdfView.document = pdfDoc
                            } else {
                                // Fallback on earlier versions
                            }
                            

                        }
                }
                
               
            }
        }

    }
