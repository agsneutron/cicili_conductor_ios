//
//  ResponseOrder.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 09/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseOrder: Mappable {
    var cantidad : Int = 0
    var direccion: String?
    var distancia: String?
    var fechaPedido: String?
    var fechaSolicitada: String?
    var formaPago: String?
    var horaSolicitada: String?
    var id : Int = 0
    var idCliente : Int = 0
    var latitud : Double = 0.0
    var longitud : Double = 0.0
    var monto: Double = 0.0
    var nombreCliente: String?
    var nombreStatus: String?
    var precio: Double = 0.0
    var status : Int = 0
    var tiempo: String?
    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id                  <- map["id"]
        nombreStatus        <- map["nombreStatus"]
        idCliente          <- map["idCliente"]
        fechaSolicitada    <- map["fechaSolicitada"]
        cantidad           <- map["cantidad"]
        horaSolicitada     <- map["horaSolicitada"]
        direccion          <- map["direccion"]
        distancia       <- map["distancia"]
        fechaPedido        <- map["fechaPedido"]
        formaPago          <- map["formaPago"]
        precio                 <- map["precio"]
        monto              <- map["monto"]
        nombreCliente      <- map["nombreCliente"]
        status             <- map["status"]
        longitud           <- map["longitud"]
        latitud            <- map["latitud"]
        tiempo            <- map["tiempo"]
    }
    
}
