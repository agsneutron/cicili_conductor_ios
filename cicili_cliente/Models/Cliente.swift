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
    
    @objc dynamic var iddevice: String?
    @objc dynamic var device: String?
    @objc dynamic var name: String?
    @objc dynamic var access_token: String?
    @objc dynamic var usertype: String?
    @objc dynamic var address: String?
    
    
    @objc dynamic var photo: String?
    
    @objc dynamic var rfcdatasize: Int = 0
    @objc dynamic var order_id: String?
    @objc dynamic var comision: String?
    @objc dynamic var total: String?
    
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
          //<- map[""]
          //<- map[""]
          //<- map[""]
          //<- map[""]
          //  <- map[""]
    }
    
    
}
