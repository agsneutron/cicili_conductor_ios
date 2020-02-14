////  MainViewController.swift//  cicili_cliente////  Created by ARIANA SANCHEZ on 05/01/20.//  Copyright © 2020 CICILI. All rights reserved.//import UIKitimport MapKitimport CoreLocationimport FirebaseAuthimport FirebaseDatabaseclass MainViewController: UIViewController, AddressTableDelegate, AvailableDriversDelegate, DataDelegate, DataOrderDelegate{        var addresRequest: AddressTable?        @IBOutlet weak var segmentConectDisconect: UISegmentedControl!    @IBOutlet weak var mapView: MKMapView!    private let locationManager = LocationManager.shared    private var locationList: CLLocation?    let regionRadius: CLLocationDistance = 1000    var myLocation:CLLocationCoordinate2D?    var currentAddress : String?    var currentUserId = Auth.auth().currentUser?.uid    let appDelegate = UIApplication.shared.delegate as! AppDelegate        //let locationManagerCL = CLLocationManager()    //let regionInMeters: Double = 10000        var cliente: Cliente?    var driverObject : [NearDrivers]?    var addressObject : [Address]?    //@IBOutlet weak var TxtAddress: UILabel!    //@IBOutlet weak var TxtDriver: UILabel!        //@IBOutlet weak var TxtAddress: UITextField!    //@IBOutlet weak var TxtDriver: UITextField!        //@IBOutlet weak var btnProgramaPedido: RoundButton!            @IBOutlet weak var TxtBienvenida: UILabel!    //@IBOutlet weak var btnMasCercano: RoundButton!        enum CardState {        case expanded        case collapsed    }        //var cardViewController:CardMapViewController!    var cardViewController:CardMapViewController!    var visualEffectView:UIVisualEffectView!    //for order    var cardOrderViewController: CardOrderViewController!    var tapOrderGestureRecognizerBtn : UITapGestureRecognizer!    var panOrderGestureRecognizerBtn : UIPanGestureRecognizer!            let cardHeight:CGFloat = 500    let cardHandleAreaHeight:CGFloat = 0        var cardVisible = false    var nextState:CardState {        return cardVisible ? .collapsed : .expanded    }        var runningAnimations = [UIViewPropertyAnimator]()    var animationProgressWhenInterrupted:CGFloat = 0        override func viewDidLoad() {        super.viewDidLoad()                setupMasCercanoCard()        setupCard()        setupOrderCard()                navigationController?.setNavigationBarHidden(true, animated: true)        // esconder el teclado        //btnMasCercano.becomeFirstResponder()        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))        //view.addGestureRecognizer(tapGesture)        // esconder el teclado        var currentLati = "0.0"        var currentLong = "0.0"        if self.locationManager.location != nil {            self.getAddressFromLatLon(location:self.locationManager.location!)            self.centerMapOnLocation(location: self.locationManager.location!)            currentLati = "\(self.locationManager.location!.coordinate.latitude)"            currentLong = "\(self.locationManager.location!.coordinate.longitude)"            self.requestMainSearch(latitude: currentLati, longitude: currentLong)        }            //TxtAddress.setLeftImage(imageName: "icon_right")        //TxtDriver.setLeftImage(imageName: "icon_right")        // Do any additional setup after loading the view.            RequestManager.fetchClientStatus(oauthToken: self.cliente!.token! , success: { response in            if let statusUpdated = response.status, !statusUpdated.isEmpty{                print("En success status updated \(statusUpdated)")                switch statusUpdated {                              case WSKeys.parameters.completo:                                debugPrint("STATUS IN C SWITCH")                                debugPrint(statusUpdated)                                //self.setupCard()                                                                self.startLocationUpdates()                                //self.getAddressFromLatLon(location:self.locationManager.location!)                                //self.checkLocationServices()                                var currentLat = "0.0"                                var currentLon = "0.0"                                if self.locationManager.location != nil {                                    self.getAddressFromLatLon(location:self.locationManager.location!)                                    self.centerMapOnLocation(location: self.locationManager.location!)                                    currentLat = "\(self.locationManager.location!.coordinate.latitude)"                                    currentLon = "\(self.locationManager.location!.coordinate.longitude)"                                    self.requestMainSearch(latitude: currentLat, longitude: currentLon)                                }                                                                                                case WSKeys.parameters.datos_personales:                                 /* guard let personalController = self.storyboard?.instantiateViewController(                                  withIdentifier: "PersonalDataStoryboard") as? PersonalDataViewController else {                                          fatalError("Unable to create PersonalDataController")                                      }                                                                                  personalController.cliente = self.self.cliente                                  self.present(personalController, animated: true, completion: nil)*/                                                                               self.performSegue(withIdentifier: Constants.Storyboard.personalDataSegueId, sender: self)                              case WSKeys.parameters.datos_pago:                                  guard let paymentController = self.storyboard?.instantiateViewController(                                  withIdentifier: "PaymentDataStoryboard") as? PaymentDataViewController else {                                          fatalError("Unable to create PaymentDataController")                                      }                                  paymentController.cliente = self.cliente                                  self.present(paymentController, animated: true, completion: nil)                                                                                // self.performSegue(withIdentifier: Constants.Storyboard.paymentDataSegueId, sender: self)                              case WSKeys.parameters.datos_direccion:                                                                                guard let addressController = self.storyboard?.instantiateViewController(                                  withIdentifier: "AddressDataStoryboard") as? AddressDataViewController else {                                          fatalError("Unable to create AddressDataController")                                      }                                  debugPrint("frommaintodir")                                  debugPrint(self.cliente?.token as Any)                                  addressController.cliente = self.cliente                                  self.present(addressController, animated: true, completion: nil)                                  //self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)                              case WSKeys.parameters.verifica_codigo:                                                                            guard let verifyCodeController = self.storyboard?.instantiateViewController(                                  withIdentifier: "VerifyStoryboard") as? VerifyCodeViewController else {                                              fatalError("Unable to create VerifyCodeController")                                              }                                verifyCodeController.token = self.cliente!.token                                  self.present(verifyCodeController, animated: true, completion: nil)                                  //self.performSegue(withIdentifier: Constants.Storyboard.adressDataSegueId, sender: self)                                                        default:                                                    debugPrint("VC MAIN switch default")                                  self.showAlertController(tittle_t: Constants.ErrorTittles.tittleStatus, message_t: Constants.ErrorMessages.messageStatus)                                                        guard let loginController = self.storyboard?.instantiateViewController(                                  withIdentifier: "LoginStoryboard") as? ViewController else {                                  fatalError("Unable to create LoginViewController")                                  }                                                                self.present(loginController, animated: true, completion: nil)                              }            }        })        { error in           debugPrint("---ERROR---")        }                TxtBienvenida.text = " ¡ Hola \(cliente!.nombre!) ! "                      }        func requestMainSearch(latitude: String, longitude: String){            RequestManager.fetchMainSearch(oauthToken: self.cliente!.token!,parameters: [WSKeys.parameters.PLATITUD: latitude, WSKeys.parameters.PLONGITUD: longitude] , success: { response in                        debugPrint("En success maisearch \(response)")            self.driverObject = response            for neardriver in response{                self.addPin(driverData: neardriver)            }                                })        { error in           debugPrint("---ERROR---")        }    }       @objc func tapGestureHandler() {        //TxtAddress.endEditing(true)        //TxtDriver.endEditing(true)    }         func addAddress(address: AddressTable) {        //self.TxtAddress.text=address.name        //self.TxtAddress.tag = address.id        //self.TxtAddress.endEditing(true)        //btnMasCercano.becomeFirstResponder()                        //debugPrint("selected address \(self.TxtAddress.tag) \(self.TxtAddress.text ?? "")")          if let addressSelected = addressObject!.first(where: { $0.id == address.id }) {        debugPrint("selected address location \(addressSelected.latitud),\(addressSelected.longitud)")        centerMapOnLocation(location: CLLocation(latitude: addressSelected.latitud, longitude: addressSelected.longitud))        addAddressPin(addressData:addressSelected)        requestMainSearch(latitude: "\(addressSelected.latitud)" , longitude:"\(addressSelected.longitud)")                self.cardViewController.selectedAddress = address.id        self.cardViewController.selectedLatitud = addressSelected.latitud        self.cardViewController.selectedLongitud = addressSelected.longitud            self.cardOrderViewController.selectedAddress = address.id        self.cardOrderViewController.selectedLatitud = addressSelected.latitud        self.cardOrderViewController.selectedLongitud = addressSelected.longitud        self.cardOrderViewController.cliente = cliente           }                    //actualiza pipas     }        func addAvailableDrivers(drivers: AvailableDrivers) {        //self.TxtDriver.text=drivers.name        //self.TxtDriver.tag = drivers.id        //self.TxtDriver.endEditing(true)        //btnMasCercano.becomeFirstResponder()            if let driverSelected = driverObject!.first(where: { $0.id == drivers.id })        {            debugPrint("selected driver  \(driverSelected.concesionario)")            self.cardOrderViewController.driverObject = driverSelected            self.cardOrderViewController.cliente = cliente        }            }    /*    // MARK: - Navigation    // In a storyboard-based application, you will often want to do a little preparation before navigation    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        // Get the new view controller using segue.destination.        // Pass the selected object to the new view controller.    }    */        private func startLocationUpdates() {                locationManager.requestAlwaysAuthorization()                locationManager.requestWhenInUseAuthorization()        if CLLocationManager.locationServicesEnabled() {            locationManager.delegate = self            locationManager.distanceFilter = kCLDistanceFilterNone            locationManager.desiredAccuracy =  kCLLocationAccuracyBest            locationManager.startUpdatingLocation()        }        mapView.delegate = self        mapView.mapType = .standard        mapView.isZoomEnabled = true        mapView.isScrollEnabled = true            }        func saveCurrentLocation(_ center:CLLocationCoordinate2D){        let message = "\(center.latitude) , \(center.longitude)"        print(message)        //self.label.text = message        myLocation = center    }           func centerMapOnLocation(location: CLLocation) {                self.saveCurrentLocation(location.coordinate)        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,                                                   latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)               mapView.setRegion(coordinateRegion, animated: true)        //mapView.showsUserLocation = true;    }            func setupCard() {        visualEffectView = UIVisualEffectView()        visualEffectView.frame = self.view.frame        //self.view.addSubview(visualEffectView)                cardViewController = CardMapViewController(nibName:"CardMapViewController", bundle:nil)        self.addChild(cardViewController)        self.view.addSubview(cardViewController.view)                            cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight+100)                cardViewController.view.clipsToBounds = true                cardViewController.delegate = self        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))            let tapGestureRecognizerBtn = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))        let panGestureRecognizerBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))                cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)                //btnProgramaPedido.addGestureRecognizer(tapGestureRecognizerBtn)        //btnProgramaPedido.addGestureRecognizer(panGestureRecognizerBtn)        //self.cardViewController.txtAlgo.text = "whats ap Men ??"                            }            func setupOrderCard() {        visualEffectView = UIVisualEffectView()        visualEffectView.frame = self.view.frame        //self.view.addSubview(visualEffectView)                cardOrderViewController = CardOrderViewController(nibName:"CardOrderViewController", bundle:nil)        self.addChild(cardOrderViewController)        self.view.addSubview(cardOrderViewController.view)                            cardOrderViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight+100)                cardOrderViewController.view.clipsToBounds = true                cardOrderViewController.delegate = self        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardTap(recognzier:)))        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardPan(recognizer:)))            let tapOrderGestureRecognizerBtn = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardTap(recognzier:)))        let panOrderGestureRecognizerBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardPan(recognizer:)))                cardOrderViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)        cardOrderViewController.handleArea.addGestureRecognizer(panGestureRecognizer)               // btnProgramaPedido.addGestureRecognizer(tapGestureRecognizerBtn)       // btnProgramaPedido.addGestureRecognizer(panGestureRecognizerBtn)            }    func setupMasCercanoCard() {        visualEffectView = UIVisualEffectView()        visualEffectView.frame = self.view.frame        //self.view.addSubview(visualEffectView)                cardViewController = CardMapViewController(nibName:"SendNearDriverViewController", bundle:nil)        self.addChild(cardViewController)        self.view.addSubview(cardViewController.view)                            cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight+100)                cardViewController.view.clipsToBounds = true                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))            let tapGestureRecognizerBtn = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleCardTap(recognzier:)))        let panGestureRecognizerBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleCardPan(recognizer:)))                cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)        //btnMasCercano.addGestureRecognizer(tapGestureRecognizerBtn)        //btnMasCercano.addGestureRecognizer(panGestureRecognizerBtn)                    }    @objc    func handleCardTap(recognzier:UITapGestureRecognizer) {        switch recognzier.state {        case .ended:            animateTransitionIfNeeded(state: nextState, duration: 0.9)        default:            break        }    }        @objc    func handleCardPan (recognizer:UIPanGestureRecognizer) {        switch recognizer.state {        case .began:            startInteractiveTransition(state: nextState, duration: 0.9)        case .changed:            let translation = recognizer.translation(in: self.cardViewController.handleArea)            var fractionComplete = translation.y / cardHeight            fractionComplete = cardVisible ? fractionComplete : -fractionComplete            updateInteractiveTransition(fractionCompleted: fractionComplete)        case .ended:            continueInteractiveTransition()        default:            break        }            }        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {        if runningAnimations.isEmpty {            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {                switch state {                case .expanded:                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight                case .collapsed:                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight                }            }                        frameAnimator.addCompletion { _ in                self.cardVisible = !self.cardVisible                self.runningAnimations.removeAll()            }                        frameAnimator.startAnimation()            runningAnimations.append(frameAnimator)                                    let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {                switch state {                case .expanded:                    self.cardViewController.view.layer.cornerRadius = 12                case .collapsed:                    self.cardViewController.view.layer.cornerRadius = 0                }            }                        cornerRadiusAnimator.startAnimation()            runningAnimations.append(cornerRadiusAnimator)                        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {                switch state {                case .expanded:                    self.visualEffectView.effect = UIBlurEffect(style: .dark)                case .collapsed:                    self.visualEffectView.effect = nil                }            }                        //blurAnimator.startAnimation()            //runningAnimations.append(blurAnimator)                    }    }        @objc    func handleOrderCardTap(recognzier:UITapGestureRecognizer) {        switch recognzier.state {        case .ended:            animateOrderTransitionIfNeeded(state: nextState, duration: 0.9)        default:            break        }    }              @objc       func handleOrderCardPan (recognizer:UIPanGestureRecognizer) {           switch recognizer.state {           case .began:               startInteractiveTransition(state: nextState, duration: 0.9)           case .changed:               let translation = recognizer.translation(in: self.cardOrderViewController.handleArea)               var fractionComplete = translation.y / cardHeight               fractionComplete = cardVisible ? fractionComplete : -fractionComplete               updateInteractiveTransition(fractionCompleted: fractionComplete)           case .ended:               continueInteractiveTransition()           default:               break           }                  }              func animateOrderTransitionIfNeeded (state:CardState, duration:TimeInterval) {           if runningAnimations.isEmpty {               let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {                   switch state {                   case .expanded:                       self.cardOrderViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight                   case .collapsed:                       self.cardOrderViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight                   }               }                              frameAnimator.addCompletion { _ in                   self.cardVisible = !self.cardVisible                   self.runningAnimations.removeAll()               }                              frameAnimator.startAnimation()               runningAnimations.append(frameAnimator)                                             let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {                   switch state {                   case .expanded:                       self.cardOrderViewController.view.layer.cornerRadius = 12                   case .collapsed:                       self.cardOrderViewController.view.layer.cornerRadius = 0                   }               }                              cornerRadiusAnimator.startAnimation()               runningAnimations.append(cornerRadiusAnimator)                              let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {                   switch state {                   case .expanded:                       self.visualEffectView.effect = UIBlurEffect(style: .dark)                   case .collapsed:                       self.visualEffectView.effect = nil                   }               }                              //blurAnimator.startAnimation()               //runningAnimations.append(blurAnimator)                          }       }        func startInteractiveTransition(state:CardState, duration:TimeInterval) {        if runningAnimations.isEmpty {            animateTransitionIfNeeded(state: state, duration: duration)        }        for animator in runningAnimations {            animator.pauseAnimation()            animationProgressWhenInterrupted = animator.fractionComplete        }    }        func updateInteractiveTransition(fractionCompleted:CGFloat) {        for animator in runningAnimations {            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted        }    }        func continueInteractiveTransition (){        for animator in runningAnimations {            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)        }    }        @IBAction func showAddressTable(_ sender: UITextField) {        //self.TxtAddress.endEditing(true)        //TxtAddress.becomeFirstResponder()        RequestManager.fetchAddressConsult(oauthToken: self.cliente!.token! , success: { response in                        print("En success status updated \(response)")            let addressView = self.storyboard?.instantiateViewController(withIdentifier: "AddressTableID") as! AddressTableViewController            addressView.delegate=self            addressView.cliente = self.cliente            addressView.addressObject = response            self.addressObject = response            self.navigationController?.pushViewController(addressView, animated: true)                                })        { error in           debugPrint("---ERROR---")        }    }                    @IBAction func showPipasTable(_ sender: UITextField) {        if driverObject?.count != 0{                        let driversView = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDriversID") as! AvailableDriversViewController            driversView.delegate=self            driversView.nearDrivers = driverObject            self.navigationController?.pushViewController(driversView, animated: true)                        }        else{            showAlertController(tittle_t: Constants.ErrorTittles.tittleDrivers, message_t: Constants.ErrorMessages.messageNoDrivers)        }    }       /*@IBAction func showAddressTableXib(_ sender: Any) {        animateTransitionIfNeeded(state: nextState, duration: 0.9)        }*/    /*@IBAction func showBSheet(_ sender: UIButton) {        let viewController: MainViewController = MainViewController()        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)        present(bottomSheet, animated: true, completion: nil)    }*/        func addPin(driverData: NearDrivers){             // show pin on map        let mapPin = MapPin(title: "\(driverData.concesionario!)",            locationName: "$\(driverData.precio) | \(driverData.tiempoLlegada!)",                            discipline: "\(driverData.tiempoLlegada!)",                            coordinate: CLLocationCoordinate2D(latitude: driverData.latitud, longitude: driverData.longitud),                            id: driverData.id)             mapView.addAnnotation(mapPin)    }        func addAddressPin(addressData: Address){             // show pin on map        let mapPin = MapPin(title: "\(addressData.alias!)",        locationName: "\(addressData.calle!) \(addressData.exterior ?? " "), \(addressData.asentamiento?.text ?? " ")",        discipline: "address",                            coordinate: CLLocationCoordinate2D(latitude: addressData.latitud, longitude: addressData.longitud),                            id: addressData.id)             mapView.addAnnotation(mapPin)    }            func getAddressFromLatLon(location: CLLocation) {              mapView.removeAnnotations(mapView.annotations)        let geo: CLGeocoder = CLGeocoder()        geo.reverseGeocodeLocation(location, completionHandler:        {(placemarks, error) in            if (error != nil)            {                print("reverse geodcode fail: \(error!.localizedDescription)")            }            let pm = placemarks! as [CLPlacemark]            debugPrint("NO PM ADDRESSLOCATION CURRENT")            if pm.count > 0 {                let pm = placemarks![0]                print(pm.country)                print(pm.locality)                print(pm.subLocality)                print(pm.thoroughfare)                print(pm.postalCode)                print(pm.subThoroughfare)                var addressString : String = ""                if pm.subLocality != nil {                    addressString = addressString + pm.subLocality! + ", "                }                if pm.thoroughfare != nil {                    addressString = addressString + pm.thoroughfare! + ", "                }                if pm.locality != nil {                    addressString = addressString + pm.locality! + ", "                }                if pm.country != nil {                    addressString = addressString + pm.country! + ", "                }                if pm.postalCode != nil {                    addressString = addressString + pm.postalCode! + " "                }                debugPrint("ADDRESSLOCATION CURRENT")                print(addressString)                    //to add pin if needed                //let myAnnotation: MKPointAnnotation = MKPointAnnotation()                //myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);                //myAnnotation.title = "Ubicación actual"                //myAnnotation.subtitle = addressString                self.currentAddress = addressString                //self.mapView.addAnnotation(myAnnotation)               }           })       }        @IBAction func eventConectDisconect(_ sender: UISegmentedControl) {        setConectDisconect()    }    //  CONECTAR DESCONECTAR    func setConectDisconect() {                    let fbToken = appDelegate.FBToken        print("Token FB : \(fbToken)")        var varStatus: String = "0"        var statusFirebase: Bool        switch segmentConectDisconect.selectedSegmentIndex        {             case 0:                varStatus = "0"                statusFirebase = false             case 1:                 varStatus = "1"                statusFirebase = true            default:                varStatus = "0"                statusFirebase = false                break        }                       RequestManager.setConectDisconect(oauthToken: cliente!.token!, parameters: [WSKeys.parameters.status: varStatus], success: { response in                                    debugPrint("En success requestorder \(response.data!)")    DataService.instance.REF_DRIVERS.child(self.currentUserId!).updateChildValues([ACCOUNT_PICKUP_MODE_ENABLED: statusFirebase])                                })        { error in            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)        }                    }           }extension MainViewController: CLLocationManagerDelegate, MKMapViewDelegate {    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {      for newLocation in locations {        let howRecent = newLocation.timestamp.timeIntervalSinceNow        guard newLocation.horizontalAccuracy < 10 && abs(howRecent) < 5 else { continue }        locationList = newLocation                getAddressFromLatLon(location: newLocation)                }            }        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate)        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)                /*if currentUserId != nil {            DataService.instance.userIsDriver(userKey: currentUserId!) { (isDriver) in                if isDriver == true {                    DataService.instance.driverIsOnTrip(driverKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in                        if isOnTrip == true {                            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: true, withKey: driverKey)                        } else {                            self.centerMapOnUserLocation()                        }                    })                } else {                    DataService.instance.passengerIsOnTrip(passengerKey: self.currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in                        if isOnTrip == true {                            self.zoom(toFitAnnotationsFromMapView: self.mapView, forActiveTripWithDriver: true, withKey: driverKey)                        } else {                            self.centerMapOnUserLocation()                        }                    })                }            }        }*/    }        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {        if let userLocation = annotation as? MKUserLocation {            userLocation.title = "Mi ubicación"            userLocation.subtitle = currentAddress        }            guard let annotation = annotation as? MapPin else { return nil }        var pinImage : UIImage        let imgPin = annotation.discipline            if  imgPin == "address" {                    pinImage =  UIImage(imageLiteralResourceName: "casa")                }else{                    pinImage = UIImage(imageLiteralResourceName: "pipa_2-1")                }             let Identifier = "Pin"         let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)               annotationView.canShowCallout = true                    if annotation is MKUserLocation {            return nil        } else if annotation is MapPin {                //annotationView!.leftCalloutAccessoryView = button               annotationView.image =  pinImage            annotationView.calloutOffset = CGPoint(x: -5, y: 5)            //annotationView.leftCalloutAccessoryView = UIButton(type: .infoDark)            //let button = UIButton(type: .detailDisclosure)                let rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 70)))            rightView.backgroundColor = .lightGray           let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 40)))            button.setTitle("Pedir", for: .normal)            button.setTitleColor(.blue, for: .normal)            button.backgroundColor = .lightGray            button.sendSubviewToBack(rightView)       /* let tapOrderGestureRecognizerBtn = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardTap(recognzier:)))        let panOrderGestureRecognizerBtn = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handleOrderCardPan(recognizer:)))                    button.addGestureRecognizer(tapOrderGestureRecognizerBtn)        button.addGestureRecognizer(panOrderGestureRecognizerBtn)    */                   annotationView.annotation = annotation as? MapPin        if annotation.discipline != "address" {            annotationView.rightCalloutAccessoryView = button        }else{            annotationView.rightCalloutAccessoryView = nil        }                       /*   if let driverSelected = driverObject!.first(where: { $0.id == annotation.id })                         {                             debugPrint("selected driver  \(driverSelected.concesionario)")                             self.cardOrderViewController.driverObject = driverSelected                             self.cardOrderViewController.cliente = cliente                                                }*/                                         return annotationView         } else {            return nil         }      }        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {        let driver = view.annotation as! MapPin        let driverid = "\(driver.id)"        let driversb = driver.subtitle        /*let ac = UIAlertController(title: driverid, message: driversb, preferredStyle: .alert)        ac.addAction(UIAlertAction(title: "OK", style: .default))        present(ac, animated: true)*/                        if let driverSelected = driverObject!.first(where: { $0.id == driver.id })        {            debugPrint("selected driver OKKK  \(driverSelected.concesionario)")            /*self.cardOrderViewController.driverObject = driverSelected            self.cardOrderViewController.cliente = cliente            self.cardOrderViewController.lblLtPrice.text = "\(driver.locationName)"*/        self.cardOrderViewController.loadDataFromPin(driverSelected,_pCliente: cliente)              }                // muestra el card view        animateOrderTransitionIfNeeded(state: nextState, duration: 0.9)                       }            /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {        guard let location = locations.last else { return }        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)        mapView.setRegion(region, animated: true)    }        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {        checkLocationAuthorization()    }       func locationManager(manager: CLLocationManager, didFailWithError error: NSError)    {        print("Error \(error)")    } */           func sendData(data : String) {                    debugPrint("data in send data \(data)")        self.performSegue(withIdentifier: Constants.Storyboard.newOrderSegueId, sender: self)        }        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        // Get the new view controller using segue.destination.        // Pass the selected object to the new view controller.           if segue.identifier ==  Constants.Storyboard.newOrderSegueId{            let newOrderController = segue.destination as! NewOrderViewController            newOrderController.cliente = self.cliente            newOrderController.order = self.cardViewController.orderResponse            newOrderController.message = self.cardViewController.messageerror                                }    }}/*extension MainViewController: AddressTableDelegate {        func addAddress(address: AddressTable) {        //self.dismiss(animated: true) {            //self.contacts.append(contact)            //self.tableView.reloadData()            //}        self.TxtAddress.text=address.name    }}*/