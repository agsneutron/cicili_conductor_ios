//
//  TankTruckData.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 23/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import ObjectMapper

class TankTruckData: Mappable {
    var id : Int = 0
    var caducidad: String?
    var placa: String?
    var clave: String?
    var color: String?
    var facturaChasis: String?
    var facturaContenedor: String?
    var marca: String?
    var modelo: String?
    var idMarca : Int = 0
    var idModelo : Int = 0
    var motor: String?
    var numeroPermiso: String?
    var municipio : Int = 0
    var nombreMunicipio: String?
    var nombreEstado: String?
    var serie: String?
    var serieCamion: String?
    var status : Int = 0
    var idConductor : Int = 0
    var conductor: String?
    var idRazonSocial : Int = 0
    var razonSocial: String?
    var idCuenta : Int = 0
    var cuenta: String?
    var ciudad: String?
    var region: String?
    var planta: String?
    

    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        // compromisos JSON
        id                  <- map["id"]
        caducidad        <- map["caducidad"]
        placa          <- map["placa"]
        clave    <- map["clave"]
        color           <- map["color"]
        facturaChasis     <- map["facturaChasis"]
        facturaContenedor          <- map["facturaContenedor"]
        marca       <- map["marca"]
        modelo        <- map["modelo"]
        idMarca          <- map["idMarca"]
        idModelo                 <- map["idModelo"]
        motor              <- map["motor"]
        numeroPermiso      <- map["numeroPermiso"]
        status             <- map["status"]
        municipio           <- map["municipio"]
        nombreMunicipio            <- map["nombreMunicipio"]
        serie            <- map["serie"]
        serieCamion            <- map["serieCamion"]
        status            <- map["status"]
        idConductor            <- map["idConductor"]
        conductor            <- map["conductor"]
        idRazonSocial            <- map["idRazonSocial"]
        razonSocial            <- map["razonSocial"]
        idCuenta            <- map["idCuenta"]
        cuenta            <- map["cuenta"]
        nombreEstado    <- map["nombreEstado"]
        ciudad    <- map["ciudad"]
        region    <- map["region"]
        planta    <- map["planta"]
    }
    
}
