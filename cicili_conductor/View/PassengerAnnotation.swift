//
//  PassengerAnnotation.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 14/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
