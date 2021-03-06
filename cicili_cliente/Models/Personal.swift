//
//  Personal.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 08/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class Personal: Mappable {

    var user: String?
    var nombre: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    var nacimiento: String?
    var sexo: String?
    var imagen: String?
      
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        // compromisos JSON
        user            <- map["user"]
        nombre          <- map["nombre"]
        apellidoPaterno <- map["apellidoPaterno"]
        apellidoMaterno <- map["apellidoMaterno"]
        nacimiento      <- map["nacimiento"]
        sexo            <- map["sexo"]
        imagen          <- map["imagen"]
    }
}


