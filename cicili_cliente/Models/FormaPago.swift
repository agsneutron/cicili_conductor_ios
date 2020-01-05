//
//  FormaPago.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 03/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class FormaPago: Mappable {
    
    var id: Int = 0
    var status: String?
    var tipoPago: Int = 0
    var numero: Int64 = 0
    var tipoTarjeta: String?
    var vencimiento: String?
    var banco: String?
    var cvv: Int = 0


    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id          <- map["id"]
        status      <- map["status"]
        tipoPago    <- map["tipoPago"]
        numero      <- map["numero"]
        tipoTarjeta <- map["tipoTarjeta"]
        vencimiento <- map["vencimiento"]
        banco       <- map["banco"]
        cvv         <- map["cvv"]
       
    }
}
