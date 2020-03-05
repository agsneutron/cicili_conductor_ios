//
//  Claim.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class Claim: Mappable {
    
    var idPedido: Int = 0
    var aclaracion: String?
    var tipoAclaracion: ReusableIdText?
   

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        // compromisos JSON
        idPedido             <- map["idPedido"]
        aclaracion           <- map["aclaracion"]
        tipoAclaracion       <- map["tipoAclaracion"]
    }
    
}
