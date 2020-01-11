//
//  Address.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 11/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class Address: Mappable {
    
    var id: Int=0
    var calle: String?
    var exterior: String?
    var interior: String?
    var latitud: Double = 0
    var longitud: Double = 0
    var cp: String?
    var alias: String?
    var favorito: Int=0
    var asentamiento: Asentamiento?

    required convenience init?(map: Map) {
        self.init()
    }
    
        func mapping(map: Map) {
        // compromisos JSON
        id          <- map["id"]
        calle       <- map["calle"]
        exterior    <- map["exterior"]
        interior    <- map["interior"]
        latitud     <- map["latitud"]
        longitud    <- map["longitud"]
        cp          <- map["cp"]
        alias       <- map["alias"]
        favorito    <- map["favorito"]
        asentamiento <- map["asentamiento"]
        
    }

}
