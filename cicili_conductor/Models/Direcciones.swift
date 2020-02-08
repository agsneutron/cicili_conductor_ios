//
//  Direcciones.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 03/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class Direcciones: Mappable {
    
    var id: Int = 0
    var calle: String?
    var longitud: Double = 0
    var latitud: Double = 0
    var exterior: String?
    var interior: String?
    var alias: String?
    var favorito: Int = 0
    var status: Int = 0
    var asentamiento: Asentamiento?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id              <- map["id"]
        calle           <- map["calle"]
        longitud        <- map["longitud"]
        latitud         <- map["latitud"]
        exterior        <- map["exterior"]
        interior        <- map["interior"]
        alias           <- map["alias"]
        favorito        <- map["favorito"]
        status          <- map["status"]
        asentamiento    <- map["asentamiento"]
       
    }
}
