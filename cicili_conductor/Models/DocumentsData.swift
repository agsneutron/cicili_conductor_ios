//
//  DocumentsData.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 22/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class DocumentsData: Mappable {
    
    var tipo: Int=0
    var nombreTipo: String?
    var status: Int=0
    var id: Int=0
    var nombreStatus: String?
    var archivo: String?


    required convenience init?(map: Map) {
        self.init()
    }
    
        func mapping(map: Map) {
        // compromisos JSON
        tipo          <- map["tipo"]
        nombreTipo       <- map["nombreTipo"]
        status    <- map["status"]
        id    <- map["id"]
        nombreStatus     <- map["nombreStatus"]
        archivo     <- map["archivo"]
        
    }

}
