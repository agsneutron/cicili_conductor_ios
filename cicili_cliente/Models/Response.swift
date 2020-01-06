//
//  Response.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 05/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//


import ObjectMapper

class Response: Mappable {

    var data: String?
    var messageError: String?
    var codeError: String?
    var response: String?
    var httpStatus: String?
   
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        data          <- map["data"]
        messageError  <- map["messageError"]
        codeError     <- map["codeError"]
        response      <- map["response"]
        httpStatus    <- map["httpStatus"]
    }
}
