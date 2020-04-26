//
//  OrderDetailViewController.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 25/04/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class OrderDetailViewController: UIViewController {

    var idPedido : String? = nil
    var historic : String? = nil
    @IBOutlet weak var txtDireccion: UILabel!
    @IBOutlet weak var txtPrecio: UILabel!
    @IBOutlet weak var txtCantidad: UILabel!
    @IBOutlet weak var txtFormaPago: UILabel!
    @IBOutlet weak var txtTiempo: UILabel!
    @IBOutlet weak var txtDistancia: UILabel!
    @IBOutlet weak var txtCliente: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtPedido: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var cliente: Cliente?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var location: CLLocationCoordinate2D?
    var stringDireccion: String?
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cliente = appDelegate.responseCliente
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(handleCancel))
        txtPedido.text = idPedido
        

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        // Do any additional setup after loading the view.
        if idPedido != nil {
            self.getPedido(pidPedido: idPedido!)
        }
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D, radius: CLLocationDistance) {
        
        //self.saveCurrentLocation(location.coordinate)
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                   latitudinalMeters: radius, longitudinalMeters: radius)
       
        mapView.setRegion(coordinateRegion, animated: true)
        //mapView.showsUserLocation = true;
    }

    func currencyFormat(tipAmount : NSNumber, txtObject : UILabel){
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
            txtObject.text = "\(formattedTipAmount)"
        }
    }
    @objc func handleCancel() {
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        if historic == "S" {
           navigationController?.setNavigationBarHidden(true, animated: true)
        }

    }
    
    func getPedido(pidPedido: String) {
     
        RequestManager.getOrderData(oauthToken: cliente!.token!, idPedido: pidPedido, success: { response in
            self.txtDireccion.text = "\(response.direccion!)"
            self.currencyFormat(tipAmount : NSNumber(value: response.monto), txtObject: self.txtPrecio)
            FunctionsApp.decimalFormat(tipAmount : NSNumber(value: response.cantidad), txtObject : self.txtCantidad, etiqueta: "")
            //self.txtPrecio.text = "\(response.monto)"
           // self.txtCantidad.text = "\(response.cantidad)"
            self.txtFormaPago.text = "\(response.formaPago!)"
            self.txtTiempo.text = "\(response.tiempo!)"
            self.txtDistancia.text = "\(response.distancia!)"
            self.txtCliente.text = "\(response.nombreCliente!)"
            self.txtStatus.text = "\(response.nombreStatus!)"
            self.txtPedido.text = "\(response.id)"
            
            self.stringDireccion = response.direccion!
            self.location =  CLLocationCoordinate2D(latitude: response.latitud, longitude: response.longitud)
            self.addAddressPin(direccion:response.direccion!)
            self.centerMapOnLocation(location: self.location!, radius:self.regionRadius)
        })
        { error in
            self.showAlertController(tittle_t: Constants.ErrorTittles.titleVerifica, message_t: error.localizedDescription)
        }
                
    }
    
    func addAddressPin(direccion: String){
             // show pin on map
        if mapView!.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        let mapPin = MapPin(title: "Ubicación del Pedido",
        locationName: "\(direccion)",
        discipline: "address",
        coordinate: CLLocationCoordinate2D(latitude: self.location!.latitude, longitude: self.location!.longitude)
            ,id: 1)
    
        mapView.addAnnotation(mapPin)
    }

}

extension OrderDetailViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let userLocation = annotation as? MKUserLocation {
            userLocation.title = "Mi ubicación"
            userLocation.subtitle = ""
        }
    
        guard let annotation = annotation as? MapPin else { return nil }
        var pinImage : UIImage
        pinImage =  UIImage(imageLiteralResourceName: "casa")

    
         let Identifier = "Pin"
        var annotationView: MKAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
        }
        
        
         annotationView.canShowCallout = true
           
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        } else if annotation.isKind(of: MapPin.self) {
    
            //annotationView!.leftCalloutAccessoryView = button
   
            annotationView.image =  pinImage
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            //annotationView.leftCalloutAccessoryView = UIButton(type: .infoDark)
            //let button = UIButton(type: .detailDisclosure)
    
            let rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 70)))
            rightView.backgroundColor = .lightGray
   
        
            annotationView.rightCalloutAccessoryView = nil
           
    
            return annotationView
         } else {
            return nil
         }
      }
    
    
   
        
}
