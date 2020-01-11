//
//  LoginModel.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 09/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation

public struct LoginResponse: Codable {
    
    
    public let  messageError: String
    public let  codeError: Int
    public let  response: Int
    public let  httpStatus: String
    public let  data: [ClienteData]
    
}
public struct ClienteData: Codable {
    
    public let idCliente: Int
    public let status: String
    public let token: String
    public let correoElectronico: String
    public let password: String
    public let nombre: String
    public let apellidoPaterno: String
    public let apellidoMaterno: String
    public let nacimiento: String
    public let telefono: String
    public let sexo: String
    public let formaPago: [ClienteFormaPago]
    public let direcciones: [ClienteDirecciones]
    public let imagen: String
}

public struct ClienteFormaPago: Codable {
    public let id: Int = 0
    public let status: Int = 0
    public let tipoPago: Int = 0
    public let numero: Int64 = 0
    public let tipoTarjeta: String?
    public let vencimiento: String?
    public let banco: String?
    public let cvv: Int = 0
}


public struct ClienteDirecciones: Codable {
    public let id: Int
    public let calle: String
    public let longitud: Double
    public let latitud: Double
    public let exterior: String
    public let interior: String
    public let alias: String
    public let favorito: Int
    public let status: Int
    public let asentamiento: DireccionesAsentamiento
}


public struct DireccionesAsentamiento: Codable {
     public let  id: Int
     public let  nombre: String
     public let  cp: Int
     public let  municipio: String
     public let  estado: String
     public let  pais: String
}
