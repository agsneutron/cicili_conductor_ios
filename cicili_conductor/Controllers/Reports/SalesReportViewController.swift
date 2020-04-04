//
//  SalesReportViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 23/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

extension UITextField{

    func setLeftImageFI(imageName:String) {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        imageView.image = UIImage(named: imageName)
        self.rightView = imageView;
        self.rightViewMode = .always
    }
}
    //este date picker es para cuando abre abajo
extension UITextField {
    
    func setInputViewDatePickerFI(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancelar", style: .plain, target: nil, action: #selector(tapCancelDate)) // 6
        let barButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancelDate() {
        self.resignFirstResponder()
    }
}

class SalesReportViewController: UIViewController {

    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var txtFechaFinal: UITextField!
    @IBOutlet weak var txtFechaInicio: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente: Cliente?
    let dateFormatter = DateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        dateFormatter.dateFormat = "dd-MM-yyyy"
        txtFechaInicio.setLeftImageFI(imageName: "icon_calendar")
         self.txtFechaInicio.setInputViewDatePickerFI(target: self, selector: #selector(tapDoneIni))
        txtFechaFinal.setLeftImageFI(imageName: "icon_calendar")
        self.txtFechaFinal.setInputViewDatePickerFI(target: self, selector: #selector(tapDoneFin))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDoneIni() {
        if let datePicker = self.txtFechaInicio.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
                dateformatter.dateStyle = .medium // 2-3
            dateformatter.locale = Locale(identifier: "es_MX")
            dateformatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
            
            self.txtFechaInicio.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtFechaInicio.resignFirstResponder() // 2-5
        
    }
    @objc func tapDoneFin() {
        if let datePicker = self.txtFechaFinal.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
                dateformatter.dateStyle = .medium // 2-3
            dateformatter.locale = Locale(identifier: "es_MX")
            dateformatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
            self.txtFechaFinal.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtFechaFinal.resignFirstResponder() // 2-5
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func excelReport(_ sender: RoundButton) {
        /*let parametros: SalesParameters?
        parametros = SalesParameters(type: "xls", initialDate: "01-10-2019", endDate: "01-03-2020", conductor: String(self.cliente!.idCliente))*/
        self.progressBar.progress = 0
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("ReporteVentas.xls")
            return (documentsURL, [.removePreviousFile])
        }
        
        var fecha: String = self.txtFechaInicio!.text!
        Alamofire.download(Router.getSalesReport(autorizathionToken: self.cliente!.token!, parametersSet: ["fecha_inicial": self.txtFechaInicio!.text! , "fecha_final": self.txtFechaFinal!.text!, "conductor": String(self.cliente!.idCliente), "autotanque": "", "planta":"", "region":""], pType: "xls", pContenttype:"application/vnd.ms-excel"), to: destination).downloadProgress(closure: { (progress) in
            
            self.progressBar.progress = Float(progress.fractionCompleted)
            
        }).responseData { response in
            if let destinationUrl = response.destinationURL {
                print("destinationUrl \(destinationUrl.absoluteURL)")
                self.showAlertController(tittle_t: Constants.AlertTittles.downloadFile, message_t: Constants.AlertMessages.messageDownloadFile)
            }else{
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleErrorDownloadFile, message_t: Constants.ErrorMessages.messageDownloadFile)
            }
        }
    }
    
    
    
    @IBAction func pdfReport(_ sender: RoundButton) {
        self.progressBar.progress = 0
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("ReporteVentas.pdf")
            return (documentsURL, [.removePreviousFile])
        }
        

        Alamofire.download(Router.getSalesReport(autorizathionToken: self.cliente!.token!, parametersSet: ["fecha_inicial": self.txtFechaInicio.text! , "fecha_final": self.txtFechaFinal.text!, "conductor": String(self.cliente!.idCliente), "autotanque": "", "planta":"", "region":""], pType: "pdf", pContenttype:"application/pdf"), to: destination).downloadProgress(closure: { (progress) in
        
        self.progressBar.progress = Float(progress.fractionCompleted)
            
        }).responseData { response in
            if let destinationUrl = response.destinationURL {
                print("destinationUrl \(destinationUrl.absoluteURL)")
                self.showAlertController(tittle_t: Constants.AlertTittles.downloadFile, message_t: Constants.AlertMessages.messageDownloadFile)
            }else{
                self.showAlertController(tittle_t: Constants.ErrorTittles.titleErrorDownloadFile, message_t: Constants.ErrorMessages.messageDownloadFile)
            }
        }
    }
    
}
