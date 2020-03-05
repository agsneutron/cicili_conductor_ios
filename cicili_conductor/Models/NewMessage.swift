//
//  NewMessage.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class NewMessage: Mappable {
    
    var aclaracion: Int = 0
    var texto: String?
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        aclaracion      <- map["aclaracion"]
        texto           <- map["texto"]
    }
    
}
