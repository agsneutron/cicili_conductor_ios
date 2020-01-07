//
//  Constants.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation

struct Constants{
    
    struct Storyboard{

        static let loginSegueId = "loginToMainSegue"
        static let passwordSegueId = "forgotPasswordSegue"
        static let registerSegueId = "loginToRegisterSegue"

    }
    
    struct ErrorTittles{
        static let titleRequerido = "Datos Obligatorios"
        static let titleVerifica = "Verifica los datos"
    }
    
    struct ErrorMessages{
        static let messageDatosRequeridos = "Por favor, ingresa los datos solicitados."
        static let messageRequeridoLogin = "Por favor, ingresa usuario y contraseña."
        static let messageVerificaLogin = "Datos de acceso incorrectos, favor de verificar"
         static let messagRequeridoCodigo = "Por favor, ingresa un código."
        static let messageVerificaCodigo = "Código incorrecto, favor de verificar."
    }
    
    struct AlertTittles{
      static let tittleValidateCode = "Validar Código"
    }
    
    struct AlertMessages{
        static let messageValidateCode = "Ingresa el código de verificación que llegó a tu correo."
        static let placeholderTextField = " * * * * * "
    }
    
    struct textAction{
        static let actionCancel = "Cancelar"
        static let actionOK = "Aceptar"
    }
}
