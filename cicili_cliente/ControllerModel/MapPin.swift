//
//  MapPin.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 25/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let discipline: String
  let coordinate: CLLocationCoordinate2D
  let id: Int
  
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, id: Int) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.id = id
    
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
}
