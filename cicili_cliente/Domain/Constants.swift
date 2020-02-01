////  Constants.swift//  cicili_cliente////  Created by ARIANA SANCHEZ on 02/01/20.//  Copyright © 2020 CICILI. All rights reserved.//import Foundationstruct Constants{        struct Storyboard{        static let loginSegueId = "presentHome"        static let passwordSegueId = "forgotPasswordSegue"        static let registerSegueId = "loginToRegisterSegue"        static let homeSegueId = "presentHome"        static let personalDataSegueId = "toPersonalDataSegue"        static let paymentDataSegueId = "toPaymentDataSegue"        static let adressDataSegueId = "toAdressDataSegue"        static let adressTableSegueId = "toAdressTableSegue"        static let addressLocationSegueId = "toAddressLocationSegue"                static let presentAddress = "presentAddressData"        static let presentPersonalData = "presentPersonalData"        static let presentAddresTable = "presentAddresTable"        static let addAddressSegue = "AddAddressSegue"                }        struct ErrorTittles{        static let titleRequerido = "Datos Obligatorios"        static let titleVerifica = "Verifica los datos"        static let tittleStatus = "Error en tu cuenta"        static let titleVerificaCP = "Verifica el Código Postal"        static let tittleDrivers = "Pipas en Zona"        }        struct ErrorMessages{        static let messageDatosRequeridos = "Por favor, ingresa los datos solicitados."        static let messageRequeridoLogin = "Por favor, ingresa usuario y contraseña."        static let messageVerificaLogin = "Datos de acceso incorrectos, favor de verificar"        static let messagRequeridoCodigo = "Por favor, ingresa un código."        static let messageVerificaCodigo = "Código incorrecto, favor de verificar."        static let messageStatus = "Ha ocurrido un error con tu cuenta, ponte en contacto con Cicili."        static let messageCardRequired = "Introduce un número de tarjeta."        static let messageVerificaCP = "Código Postal sin Colonias, favor de verificar."        static let messageNoDrivers = "No hay pipas disponibles por el momento para tu zona"        static let messageCantidad = "Indica los litros o precio a pagar."        }        struct AlertTittles{        static let tittleValidateCode = "Validar Código"        static let tittleTryValidateCode = "Intenta nuevamente "        static let tCodeVerificationSuccess = "Verificación exitosa"        static let tChangeSuccess = "Cambio exitoso"    }        struct AlertMessages{        static let messageValidateCode = "Ingresa el código de verificación que llegó a tu correo."        static let placeholderTextField = " * * * * * "        static let codeVerificationSuccess = "Has finalizado tu registro, ahora puedes iniciar sesión en Cicili."        static let changeSuccess = "Has finalizado tu cambio de contraseña, ahora puedes iniciar sesión en Cicili."        static let codeVerificationSuccessPws = "Ahora puedes establecer tu nueva contraseña"        static let messageTryValidateCode = "Código incorrecto, ingresa el código de verificación que llegó a tu correo."            }        struct textAction{        static let actionCancel = "Cancelar"        static let actionOK = "Aceptar"        static let actionSignIn = "INICIAR SESIÓN"        static let orderInMonto = "Monto"        static let orderInLitros = "Litros"            }}