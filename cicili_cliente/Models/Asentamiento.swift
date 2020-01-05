//
//  Asentamiento.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 03/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//


import ObjectMapper

class Asentamiento: Mappable {
    
    var id: Int = 0
    var nombre: String?
    var cp: Int = 0
    var municipio: String?
    var estado: String?
    var pais: String?
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id          <- map["id"]
        nombre      <- map["nombre"]
        cp          <- map["cp"]
        municipio   <- map["municipio"]
        estado      <- map["estado"]
        pais        <- map["pais"]
    }
}

