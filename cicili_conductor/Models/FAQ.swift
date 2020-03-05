//
//  FAQ.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class FAQ: Mappable {
    
    var id: Int = 0
    var pregunta: String?
   var respuesta: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id             <- map["id"]
        pregunta           <- map["pregunta"]
         respuesta           <- map["respuesta"]
    }
}
