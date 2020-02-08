//
//  Status.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 16/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class Status: Mappable {

    var idCliente: Int = 0
    var status: String?
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        idCliente   <- map["idCliente"]
        status      <- map["status"]
    }
}

