//
//  AccountData.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 27/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class AccountData: Mappable {
    
    var id: Int = 0
    var clabe: String?
    var nombreBanco: String?
    var banco: String?



    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        // AccountData JSON
        id          <- map["id"]
        clabe      <- map["clabe"]
        nombreBanco    <- map["nombreBanco"]
        banco      <- map["banco"]
    }
}

