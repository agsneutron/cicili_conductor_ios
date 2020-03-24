////  Constants.swift//  cicili_cliente////  Created by ARIANA SANCHEZ on 02/01/20.//  Copyright © 2020 CICILI. All rights reserved.//import Foundationstruct Constants{        struct Storyboard{        static let loginSegueId = "presentHome"        static let passwordSegueId = "forgotPasswordSegue"        static let registerSegueId = "loginToRegisterSegue"        static let verifyCodeSegue = "verifyCodeSegue"        static let homeSegueId = "presentHome"        static let personalDataSegueId = "toPersonalDataSegue"        static let registerPasswordSegue = "registerPasswordSegue"        static let paymentDataSegueId = "toPaymentDataSegue"        static let adressDataSegueId = "toAdressDataSegue"        static let adressTableSegueId = "toAdressTableSegue"        static let addressLocationSegueId = "toAddressLocationSegue"        static let segueToAcceptOrder = "seguetoacceptorder"        static let newOrderSegueId = "toNewOrderSegue"        static let segueAcceptOrder = "segueAcceptOrder"        static let segueComments = "segueComments"        static let historicalSegue = "historicalSegue"        static let segueAccountUpdate = "segueAccountUpdate"                        static let presentAddress = "presentAddressData"        static let presentPersonalData = "presentPersonalData"        static let presentAddresTable = "presentAddresTable"        static let addAddressSegue = "AddAddressSegue"        static let tankTruckSegue = "TankTruckSegue"        static let accountSegue = "AccountSegue"        static let documentsSegue = "DocumentsSegue"            static let toAskSegueId = "toAskSegue"        static let tofaqdetailSegueId = "toFAQDetailSegue"        static let messageSegueId = "toMessageSegue"        static let segueChat = "segueChat"                        }        struct ErrorTittles{        static let titleRequerido = "Datos Obligatorios"        static let titleVerifica = "Verifica los datos"        static let tittleStatus = "Error en tu cuenta"        static let titleVerificaCP = "Verifica el Código Postal"        static let tittleDrivers = "Pipas en Zona"        static let titleErrorOrder = "Pedido no disponible"        static let titleRequeridoMin = "Cantidad mínima requerida"            static let titleErrorMsg = "Error al enviar tu mensaje"        }        struct ErrorMessages{        static let messageDatosRequeridos = "Por favor, ingresa los datos solicitados."        static let messageRequeridoLogin = "Por favor, ingresa usuario y contraseña."        static let messageVerificaLogin = "Datos de acceso incorrectos, favor de verificar"        static let messagRequeridoCodigo = "Por favor, ingresa un código."        static let messageVerificaCodigo = "Código incorrecto, favor de verificar."        static let messageStatus = "Ha ocurrido un error con tu cuenta, ponte en contacto con Cicili."        static let messageCardRequired = "Introduce un número de tarjeta."        static let messageVerificaCP = "Código Postal sin Colonias, favor de verificar."        static let messageNoDrivers = "No hay pipas disponibles por el momento para tu zona"        static let messageCantidad = "Indica los litros o precio a pagar."        static let messageNewOrderError = "Ha ocurrido un error al procesar tu pedido"        static let messageCantidadMin = "El monto mínimo del pedido es de $200.00MXN."        static let messageSelectReason = "Debes seleccionar un motivo"        }        struct AlertTittles{        static let tittleValidateCode = "Validar Código"        static let tittleTryValidateCode = "Intenta nuevamente "        static let tCodeVerificationSuccess = "Verificación exitosa"        static let tChangeSuccess = "Cambio exitoso"        static let titleClaim =  "Aclaración enviada"        static let titleAsk =  "Pregunta enviada"        static let titleOrderCanceled =  "Pedido Cancelado"        static let titleOrderUpdated =  "Pedido Modificado"    }        struct AlertMessages{        static let messageValidateCode = "Ingresa el código de verificación que llegó a tu correo."        static let placeholderTextField = " * * * * * "        static let codeVerificationSuccess = "Has finalizado tu registro, ahora puedes iniciar sesión en Cicili."        static let changeSuccess = "Has finalizado tu cambio de contraseña, ahora puedes iniciar sesión en Cicili."        static let codeVerificationSuccessPws = "Ahora puedes establecer tu nueva contraseña"        static let messageTryValidateCode = "Código incorrecto, ingresa el código de verificación que llegó a tu correo."            static let messageSuccess = "Se actualizó la imagen de perfil correctamente"        static let messageSuccessClaim = "En breve responderemos a tu asunto."        static let messageSuccessAsk = "En breve responderemos a tu pregunta."        static let messageOrderCanceled = "Su pedido ha sido cancelado."        static let messageOrderUpdated = "Su pedido ha sido modificado."            }        struct textAction{        static let actionCancel = "Cancelar"        static let actionOK = "Aceptar"        static let actionSignIn = "INICIAR SESIÓN"        static let orderInMonto = "Monto"        static let orderInLitros = "Litros"        static let lblHeaderOrderNumber = "Número de Orden"        static let lblHeaderOrderStatus = "Estatus del Pedido"    }        }// Accountlet ACCOUNT_IS_DRIVER = "isDriver"let ACCOUNT_PICKUP_MODE_ENABLED = "isPickupModeEnabled"let ACCOUNT_TYPE_PASSENGER = "PASSENGER"let ACCOUNT_TYPE_DRIVER = "DRIVER"// Locationlet COORDINATE = "coordinate"// Triplet TRIP_COORDINATE = "tripCoordinate"let TRIP_IS_ACCEPTED = "tripIsAccepted"let TRIP_IN_PROGRESS = "tripIsInProgress"// Userlet USER_PICKUP_COORDINATE = "pickupCoordinate"let USER_DESTINATION_COORDINATE = "destinationCoordinate"let USER_PASSENGER_KEY = "passengerKey"let USER_IS_DRIVER = "userIsDriver"// Driverlet DRIVER_KEY = "driverKey"let DRIVER_IS_ON_TRIP = "driverIsOnTrip"let CICILI_DRIVER_KEY = "ciciliDriverKey"// Map Annotations//let ANNO_DRIVER = "driverAnnotation"let ANNO_PICKUP = "currentLocationAnnotation"let ANNO_DESTINATION = "destinationAnnotation"let ANNO_DRIVER = "pipa_2-1"// Map Regionslet REGION_PICKUP = "pickup"let REGION_DESTINATION = "destination"// Storyboardlet MAIN_STORYBOARD = "Main"// ViewControllerslet VC_LEFT_PANEL = "LeftSidePanelVC"let VC_HOME = "HomeVC"let VC_LOGIN = "LoginVC"let VC_PICKUP = "PickupVC"// TableViewCellslet CELL_LOCATION = "locationCell"// UI Messaginglet MSG_SIGN_UP_SIGN_IN = "Sign Up / Login"let MSG_SIGN_OUT = "Sign Out"let MSG_PICKUP_MODE_ENABLED = "PICKUP MODE ENABLED"let MSG_PICKUP_MODE_DISABLED = "PICKUP MODE DISABLED"let MSG_REQUEST_RIDE = "REQUEST RIDE"let MSG_START_TRIP = "START TRIP"let MSG_END_TRIP = "END TRIP"let MSG_GET_DIRECTIONS = "GET DIRECTIONS"let MSG_CANCEL_TRIP = "CANCEL TRIP"let MSG_DRIVER_COMING = "DRIVER COMING"let MSG_ON_TRIP = "ON TRIP"let MSG_PASSENGER_PICKUP = "Passenger Pickup Point"let MSG_PASSENGER_DESTINATION = "Passenger Destination"// Error Messageslet ERROR_MSG_NO_MATCHES_FOUND = "No matches found. Please try again!"let ERROR_MSG_INVALID_EMAIL = "Sorry, the email you've entered appears to be invalid. Please try another email."let ERROR_MSG_EMAIL_ALREADY_IN_USE = "It appears that email is already in use by another user. Please try again."let ERROR_MSG_WRONG_PASSWORD = "The password you tried is incorrect. Please try again."let ERROR_MSG_UNEXPECTED_ERROR = "There has been an unexpected error. Please try again."