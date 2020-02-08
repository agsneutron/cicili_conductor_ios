//
//  MapPinViews.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 25/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import MapKit

@available(iOS 11.0, *)
class MapPinView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
    
      guard let mapPin = newValue as? MapPin else { return }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      
      //markerTintColor = artwork.markerTintColor
      glyphText = String(mapPin.discipline.first!)
    }
  }
}
