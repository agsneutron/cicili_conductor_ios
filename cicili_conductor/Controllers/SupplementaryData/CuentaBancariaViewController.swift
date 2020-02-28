//
//  CuentaBancariaViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 27/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import Foundation
import UIKit
import ObjectMapper



class CuentaBancariaViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var addPaymentMethod: UIButton!
   
    
    var paymentDataVC: PaymentDataViewController!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cliente : Cliente?
    var slidePayment:[SlidePayment] = [];
    var singleSlide: SlidePayment?
    var frame = CGRect.zero
    var selectedCategory: String?
    var categoryList = [ReusableIdText]()
    var selectedCategoryId: Int = 0
    var PaymentData = [AccountData]()
    var paymentToDelete: Int = 0
    var accountData: AccountData?
    
    var accountNumber: String?
    var bank: String?
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPaymentMethod.isEnabled = true
        self.cliente = appDelegate.responseCliente
        categoryList.removeAll()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
               view.addGestureRecognizer(gesture)
        
        createPickerView()
        dismissPickerView()
        getAccountData()
        
       NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAccountUpdate(notification:)), name: Notification.Name("NotificationAccountUpdate"), object: nil)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Regresar", style: .plain, target: self, action: #selector(handleCancel))

            // Do any additional setup after loading the view.
    }
        
    @objc func handleCancel() {
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
            navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func NotificationAccountUpdate(notification: Notification){
      print("Llego notificacion a la cuenta")
      self.viewDidAppear(true)
      }
   
    func createPickerView() {
              let pickerView = UIPickerView()
              pickerView.delegate = self
              //txtUseCFDI.inputView = pickerView
    }
    
    func dismissPickerView() {
          let toolBar = UIToolbar()
          toolBar.sizeToFit()
          let button = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(self.action))
          toolBar.setItems([button], animated: true)
          toolBar.isUserInteractionEnabled = true
          //txtUseCFDI.inputAccessoryView = toolBar
    }
    
    
    func getAccountData(){
        RequestManager.getAccountData(oauthToken: self.cliente!.token!, idConductor: String(self.cliente!.idCliente), success: { response in
            self.accountData=response
                self.initSlides()
            })
            { error in
               debugPrint("---ERROR---")
            }
    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        print("****************VIEWDIDAPPEAR*******************")
        self.initSlides()
        PaymentData.removeAll()
       /*  RequestManager.fetchPaymentConsult(oauthToken: self.cliente!.token!, success: { response in
                              
            print("En success PaymentConsult list  \(response)")
                             
            for payment in response{
                    self.PaymentData.append(payment)
            }
            self.initSlides()
                  
        })
        { error in
            debugPrint("---ERROR---")
        }*/
    }
    
    func initSlides(){
        
        slidePayment = createSlidePaymentIni()
        setupSlidePaymentScrollView(slidePayment: slidePayment)
        setupSlidePaymentScrollView(slidePayment: slidePayment)
                            
        pageControl.numberOfPages = slidePayment.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
                             
        setupScreens()
        scrollView.delegate = self
        
        
        addPaymentMethod.isEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createSlidePaymentIni() -> [SlidePayment] {

                
        let slide1:SlidePayment = Bundle.main.loadNibNamed("SlidePayment", owner: self, options: nil)?.first as! SlidePayment
        slide1.imagen.image = UIImage(named: "visa_logo")
                
        slide1.cardNumberLabel.text = "\(self.accountData!.clabe!)"
        slide1.cardNumberLabel.font = UIFont(name: "\(self.accountData!.clabe!)", size: UIFont.labelFontSize)
        //slide1.tipoTarjeta.text = "\(String(describing: self.accountData!.nombreBanco!))"
        slide1.nombreBanco.text = "\(String(describing: self.accountData!.nombreBanco!))"
        //slide1.fechaValida.text = "\(String(describing: self.accountData!.nombreBanco!))"
        slide1.tag = self.accountData!.id
        slidePayment.append(slide1)
        
        return slidePayment
    }
    
    
    
    
    func setupSlidePaymentScrollView(slidePayment : [SlidePayment]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slidePayment.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slidePayment.count {
            slidePayment[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slidePayment[i])
        }
    }
    

   func setupScreens() {
       // 3.
       scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(slidePayment.count)), height: scrollView.frame.size.height)
       scrollView.delegate = self
    scrollView.reloadInputViews()
   }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
         paymentToDelete = Int(pageNumber)
        debugPrint("SELECTEDSCROLL \(pageNumber)")
    }
    
   
    
    func cancelDelete(action: UIAlertAction) {
            dismiss(animated: true, completion: nil)
    }
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return categoryList.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row].text // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        selectedCategoryId = categoryList[row].id
         debugPrint(selectedCategoryId)
        selectedCategory = categoryList[row].text// selected item
        //txtUseCFDI.text = selectedCategory
    }
   
    
    
    @IBAction func openUpdateAccount(_ sender: RoundButton) {
        self.performSegue(withIdentifier: Constants.Storyboard.segueAccountUpdate, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier ==  Constants.Storyboard.segueAccountUpdate{
            let segueController = segue.destination as! AccountUpdateViewController
            segueController.accountNumber = self.accountData!.clabe!
        }
    }
    
}

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}
