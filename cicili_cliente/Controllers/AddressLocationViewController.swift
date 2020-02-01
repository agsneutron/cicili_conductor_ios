//
//  AddressLocationViewController.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 25/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import MapKit
import ObjectMapper
import CoreLocation

class AddressLocationViewController: UIViewController {
    
    var addressObject: Address?
    var cliente: Cliente?
    var dataForLocation: String?
    
    @IBOutlet weak var aliasLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    //let locationManager = CLLocationManager()
    private let locationManager = LocationManager.shared
    private var locationList: CLLocation?
    let regionRadius: CLLocationDistance = 1000
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //map
        startLocationUpdates()
        centerMapOnLocation(location: locationManager.location!)
        //mapView.register(MapPinView.self,forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let address = "\(addressObject!.calle!) \(addressObject!.exterior ?? "")  \(addressObject!.asentamiento!.text!), \(addressObject!.cp ?? "")"
        debugPrint("____addrress for location")
        debugPrint(address)
        getLocation(from: address)
        //addPin(location: locationManager.location!)
        //checkLocationAuthorizationStatus()
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
        aliasLabel.text = "Ubicación de: \(addressObject!.alias!)"
    }
    
    func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {

        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      locationManager.stopUpdatingLocation()
    }
    
    func getLocation(from: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(from) { placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat ?? 0.0), Lon: \(lon ?? 0.0)")
            self.centerMapOnLocation(location: CLLocation(latitude: lat!, longitude: lon!))
            self.addPin(location: CLLocation(latitude: lat!, longitude: lon!))
            self.addressObject?.latitud = lat!
            self.addressObject?.longitud = lon!
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
    
    
       @IBAction func saveAddressAndLocation(_ sender: UIButton) {
        let objectAsDict:[String : AnyObject] = Mapper<Address>().toJSON(addressObject!) as [String : AnyObject]
           
        RequestManager.setAddressData(oauthToken: cliente!.token!, parameters: objectAsDict, success: { response in
               
               if response.codeError == WSKeys.parameters.okresponse{
                   print("En success \(response)")
                   //self.performSegue(withIdentifier: Constants.Storyboard.loginSegueId, sender: self)
                 self.performSegue(withIdentifier: Constants.Storyboard.homeSegueId, sender: self)
    
                   //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainStoryboard")
                   //self.present(vc!, animated: true, completion: nil)
                   
                   }
               })
               { error in
                   self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
               }
       }
       
    private func startLocationUpdates() {
      locationManager.delegate = self
      locationManager.distanceFilter = 2
      locationManager.startUpdatingLocation()
      
    }
    
    func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPin(location: CLLocation){
        // show pin on map
        let mapPin = MapPin(title: "Ubicación de:" + addressObject!.alias!,
                            locationName: addressObject!.calle! + " " + addressObject!.exterior!,
                            discipline: (addressObject?.asentamiento!.text)!,
                            coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                            id: addressObject!.id)
  
        
        mapView.addAnnotation(mapPin)
    }
    
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        
       
        
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addressObject?.latitud = locationOnMap.latitude
            addressObject?.longitud = locationOnMap.longitude
            addAnnotation(location: locationOnMap)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
         mapView.removeAnnotations(mapView.annotations)
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Cicili llegará a este punto"
            annotation.subtitle = addressObject!.alias!
            self.mapView.addAnnotation(annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   
        if segue.identifier == Constants.Storyboard.homeSegueId{
    
            let mainTab = segue.destination as! UITabBarController
            let mainVC = mainTab.viewControllers!.first as! MainViewController

            //let displayVC = segue.destination as! MainViewController
            mainVC.cliente = self.cliente
        }
        
    }

}

extension AddressLocationViewController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for newLocation in locations {
      let howRecent = newLocation.timestamp.timeIntervalSinceNow
      guard newLocation.horizontalAccuracy < 10 && abs(howRecent) < 5 else { continue }

      locationList = newLocation
    }
  }
}


