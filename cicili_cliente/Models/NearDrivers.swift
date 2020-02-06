//
//  NearDrivers.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 28/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import Foundation
import ObjectMapper

class NearDrivers: Mappable {
    
    var id: Int = 0
    var idAutotanque: Int = 0
    var idConcesionario: Int = 0
    var idConductor: Int64 = 0
    var precio: Double = 0.0
    var conductor:  String?
    var concesionario:  String?
    var tiempoLlegada:  String?
    var latitud: Double = 0.0
    var longitud: Double = 0.0
   

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id             <- map["id"]
        idAutotanque        <- map["idAutotanque"]
        idConcesionario     <- map["idConcesionario"]
        idConductor         <- map["idConductor"]
        precio              <- map["precio"]
        conductor           <- map["conductor"]
        concesionario       <- map["concesionario"]
        tiempoLlegada       <- map["tiempoLlegada"]
        latitud             <- map["latitud"]
        longitud            <- map["longitud"]
    }
    
}
