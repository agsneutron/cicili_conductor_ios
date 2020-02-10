//
//  WSKeys.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 30/12/19.
//  Copyright © 2019 CICILI. All rights reserved.
//

struct WSKeys {
    struct API
    {
        static let protocolo    = "http://"
        static let host         = "34.66.139.244"
        static let port         = ":8080/"
        static let path         = "app/"
        static let url     = WSKeys.API.protocolo + WSKeys.API.host + WSKeys.API.port + WSKeys.API.path
    }
    
    struct parameters {
        static let expired = "token_expired"
        static let okresponse = 0
        static let error = "codeError"
        static let token = "token"
        static let messageError = "messageError"
        static let response = "response"
        static let httpStatus = "httpStatus"
        static let data = "data"
        static let statuscode = 200
        static let okVerification = "true"
        
        
        static let PUSERNAME = "user"
        static let PPASSWORD = "password"
        static let PTOKENDISPOSITIVO = "token_dispositivo"
        static let PEMAIL = "correo_electronico"
        static let PCELLPHONE = "telefono"
        static let PTMPPASSWORD = "tmp_password"
        static let PLATITUD = "latitud"
        static let PLONGITUD = "longitud"
        
        static let verifica_codigo = "VE"
        static let datos_personales = "PE"
        static let datos_pago = "PA"
        static let datos_direccion = "PD"
        static let datos_rfc = "PR"
        static let datos_programar = "SO"
        static let completo = "C"
        
        static let fechanacimiento = "nacimiento"
        
        static let efectivo = 1
        static let TDD = 2
        static let TDC = 3
        
        static let dtarjeta = "TARJETA"
        static let defectivo = "EFECTIVO"
        static let dTDD = "TDD"
        static let dTDC = "TDC"
        
        static let hombre = "Hombre"
        static let mujer = "Mujer"
        static let noindicar = "No Indicar"
        
        static let pedido = "pedido"
        static let motivo = "motivo"
        
        static let calificacion="calificacion"
        static let comentario="comentario"
        
        static let cplenght = 4
        
        
        static let latitude = "latitud"
        static let longitude = "longitud"
        static let concesionario = "concesionario"
        static let conductor = "conductor"
        
        static let id = "id"
        static let no_error_ok = 1
        
        static let cantidad = "cantidad"
        static let monto = "monto"
        
        static let status = "status"
        

    }
}

