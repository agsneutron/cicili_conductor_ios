//
//  NewOrder.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 04/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class NewOrder: Mappable {
    
    var idCliente : Int = 0
    var fechaSolicitada: String?
    var cantidad : Int = 0
    var horaSolicitada: String?
    var direccion: String?
    var nombreConcesionario: String?
    var nombreStatus: String?
    var fechaPedido: String?
    var alias: String?
    var formaPago: String?
    var id : Int = 0
    var monto: Double = 0.0
    var nombreConductor: String?
    var nombreCliente: String?
    var placa: String?
    var status : Int = 0
    var longitud : Double = 0.0
    var latitud : Double = 0.0

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
         nombreConcesionario    <- map["nombreConcesionario"]
         nombreStatus       <- map["nombreStatus"]
         fechaPedido        <- map["fechaPedido"]
         alias              <- map["alias"]
         formaPago          <- map["formaPago"]
         id                 <- map["id"]
         monto              <- map["monto"]
         nombreConductor    <- map["nombreConductor"]
         nombreCliente      <- map["nombreCliente"]
         placa              <- map["placa"]
         status             <- map["status"]
         longitud           <- map["longitud"]
         latitud            <- map["latitud"]
    }
    
}


