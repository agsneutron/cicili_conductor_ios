//
//  ResponseData.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 18/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class ResponseData: Mappable {

    var completados: Int = 0
    var idConductor: Int = 0
    var calificacion: Int = 0
   
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        completados  <- map["completados"]
        idConductor  <- map["idConductor"]
        calificacion <- map["calificacion"]
    }
}
