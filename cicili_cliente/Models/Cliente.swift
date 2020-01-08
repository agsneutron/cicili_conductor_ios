//
//  Cliente.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper


class Cliente: Mappable {
    
    var idCliente: Int = 0
    var status: String?
    var token: String?
    var correoElectronico: String?
    var password: String?
    var nombre: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    var nacimiento: String?
    var telefono: String?
    var sexo: String?
    var formaPago: [FormaPago]?
    var direcciones: [Direcciones]?
    var imagen: String?

    
    // MARK: - Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        idCliente         <- map["idCliente"]
        status            <- map["status"]
        token             <- map["token"]
        correoElectronico <- map["correoElectronico"]
        password          <- map["password"]
        nombre            <- map["nombre"]
        apellidoPaterno   <- map["apellidoPaterno"]
        apellidoMaterno   <- map["apellidoMaterno"]
        nacimiento        <- map["nacimiento"]
        telefono          <- map["telefono"]
        sexo              <- map["sexo"]
        formaPago         <- map["formaPago"]
        direcciones       <- map["direcciones"]
        imagen            <- map["imagen"]
          //<- map[""]
          //<- map[""]
          //<- map[""]
          //<- map[""]
          //  <- map[""]
    }
    
    
}
