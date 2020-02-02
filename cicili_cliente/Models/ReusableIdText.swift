//
//  ReusableIdText.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
class ReusableIdText: Mappable {
    
    var id: Int = 0
    var text: String?
   

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id             <- map["id"]
        text           <- map["text"]
    }
    
}
