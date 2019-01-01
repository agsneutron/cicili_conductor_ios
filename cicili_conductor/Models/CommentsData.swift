//
//  Comments.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 31/12/18.
//  Copyright © 2018 CICILI. All rights reserved.
//

import ObjectMapper

class CommentsData: Mappable {
    
    var idPedido: Int=0
    var fecha: String?
    var calificacion: Int=0
    var comentario: String?
    var nombreCliente: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
        func mapping(map: Map) {
        // compromisos JSON
        idPedido          <- map["idPedido"]
        fecha       <- map["fecha"]
        calificacion    <- map["calificacion"]
        comentario    <- map["comentario"]
        nombreCliente     <- map["nombreCliente"]
        
    }

}
