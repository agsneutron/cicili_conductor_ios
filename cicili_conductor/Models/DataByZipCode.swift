//
//  DataByZipCode.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 17/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class DataByZipCode: Mappable {
    
    var id: Int = 0
    var pais: KeysDetailZC?
    var estado: KeysDetailZC?
    var municipio: KeysDetailZC?
    var asentamientos: [KeysDetailZC]?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id             <- map["id"]
        pais           <- map["pais"]
        estado         <- map["estado"]
        municipio      <- map["municipio"]
        asentamientos   <- map["asentamientos"]
       
    }
}
