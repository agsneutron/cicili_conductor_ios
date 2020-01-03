//
//  Cliente.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper


class Cliente: Mappable {
    
    @objc dynamic var username: String?
    @objc dynamic var lastname: String?
    @objc dynamic var lastsname: String?
    @objc dynamic var idcte: Int = 0
    @objc dynamic var status: String?
    @objc dynamic var token: String?
    @objc dynamic var iddevice: String?
    @objc dynamic var date: String?
    @objc dynamic var device: String?
    @objc dynamic var name: String?
    @objc dynamic var access_token: String?
    @objc dynamic var usertype: String?
    @objc dynamic var address: String?
    @objc dynamic var email: String?
    @objc dynamic var cellphone: String?
    @objc dynamic var photo: String?
    @objc dynamic var sexo: String?
    @objc dynamic var rfcdatasize: Int = 0
    @objc dynamic var order_id: String?
    @objc dynamic var comision: String?
    @objc dynamic var total: String?
    
    // MARK: - Initialization
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        name         <- map["username"]
        lastname     <- map["lastname"]
        lastsname    <- map["lastsname"]
        idcte        <- map["idcte"]
        status       <- map["status"]

    }
    
    
}
