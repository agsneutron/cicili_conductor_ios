//
//  Message.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 03/03/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import ObjectMapper

class Message: Mappable {
    
    var  mensaje: String?
    var  urlFoto: String?
    var  nombre: String?
    var  fotoPerfil: String?
    var  type_mensaje: String?

    var  id: Int = 0
    var  idPedido:  Int = 0
    var  aclaracion:  Int = 0
    var  usuario: String?
    var  idUsuario:  Int = 0
    var  texto: String?
    var  fecha: String?
    var  hora: String?
   

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        //  JSON
        mensaje <- map["mensaje"]
        urlFoto <- map["urlFoto"]
        nombre <- map["nombre"]
        fotoPerfil <- map["fotoPerfil"]
        type_mensaje <- map["type_mensaje"]
        id <- map["id"]
        idPedido <- map["idPedido"]
        aclaracion <- map["aclaracion"]
        usuario <- map["usuario"]
        idUsuario <- map["idUsuario"]
        texto <- map["texto"]
        fecha <- map["fecha"]
        hora <- map["hora"]
    }
}
