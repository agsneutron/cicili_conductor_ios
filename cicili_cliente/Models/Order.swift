//
//  Order.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 31/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class Order: Mappable {
    
    var cantidad: Double = 0.0
    var monto: Double = 0.0
    var domicilio: Address?
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    var formaPago: String?
    var idAutotanque: Int = 0
    
    // MARK: - Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        cantidad         <- map["cantidad"]
        monto            <- map["monto"]
        domicilio        <- map["domicilio"]
        latitud          <- map["latitud"]
        longitud         <- map["longitud"]
        formaPago        <- map["formaPago"]
        idAutotanque     <- map["idAutotanque"]
        
    }
}
