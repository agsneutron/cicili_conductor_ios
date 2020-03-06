//
//  Router.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
   
   // Base URL for OAuth2 authentication
    static let baseURLString = WSKeys.API.url
    static var OAuthToken: String?
    static var codeValue: String?
    static var latValue: String?
    static var lonValue: String?
    
    case signIn(with: Parameters)
    case registerClient(with: Parameters)
    case validateCodePsw(with: Parameters)
    case validateCodeRegister(autorizathionToken:String , code:String)
    case help(autorizathionToken:String)
    case requestPassword(with: Parameters)
    case changuePassword(with: Parameters)
    case personalData(autorizathionToken:String , parametersSet: Parameters)
    case paymentData(autorizathionToken:String , parametersSet: Parameters)
    case addressData(autorizathionToken:String , parametersSet: Parameters)
    case addressConsult(autorizathionToken: String)
    case bankData(autorizathionToken: String , bin: String)
    case clientStatus(autorizathionToken: String)
    case searchZC(autorizathionToken: String , code: String)
    case mainSearch(autorizathionToken: String , parametersSet: Parameters)
    case order(autorizathionToken: String , parametersSet: Parameters)
    case cancelReason(autorizathionToken: String)
    case cancelOrder(autorizathionToken: String, parametersSet: Parameters)
    
    //******* Conductor
    case getOrder(autorizathionToken: String , idPedido: String)
    case setConectDisconect(autorizathionToken: String , parametersSet: Parameters)
    case setUpdateCoordinate(autorizathionToken: String , parametersSet: Parameters)
    case updateColorTankTruck(autorizathionToken: String , parametersSet: Parameters)
    case acceptOrder(autorizathionToken: String , parametersSet: Parameters)
    case changeStatusOrder(autorizathionToken: String , parametersSet: Parameters)
    case getQualifications(autorizathionToken: String)
    case getComments(autorizathionToken: String)
    case getHistorical(autorizathionToken: String)
    case getWeeks(autorizathionToken: String)
    case getBanks(autorizathionToken: String)
    case getBoardData(autorizathionToken: String, idWeek: String)
    case getDocumentsData(autorizathionToken: String, idConductor: String)
    case getTankTruck(autorizathionToken: String)
    case getSalesReport(autorizathionToken: String, parametersSet: Parameters, pType: String, pContenttype: String)
    case getLitersReport(autorizathionToken: String, parametersSet: Parameters, pType: String, pContenttype: String)
    case getAccountData(autorizathionToken: String, idConductor: String)
    case changeDataAccount(autorizathionToken: String , parametersSet: Parameters)
    
    case consultAsk(autorizathionToken: String)
    case faqList(autorizathionToken: String, id: String)
    case getMessages(autorizathionToken: String, id: String)
    case getChatMessages(autorizathionToken: String, id: String)
    case sendMessage(autorizathionToken: String, parametersSet: Parameters)
    case sendChatMessage(autorizathionToken: String, parametersSet: Parameters)
    case claimType(autorizathionToken: String)
    case claimData(autorizathionToken: String, parametersSet: Parameters)
    
    // HTTP method
       
    var method: HTTPMethod {
        switch self {
        case.help,
            .clientStatus,
            .searchZC,
            .bankData,
            .addressConsult,
            .mainSearch,
            .getOrder,
            .getQualifications,
            .getComments,
            .getBoardData,
            .getDocumentsData,
            .getAccountData,
            .getHistorical,
            .claimType,
            .getWeeks,
            .getBanks,
            .getSalesReport,
            .getLitersReport,
            .getTankTruck,
            .cancelReason,
            .consultAsk,
            .faqList,
            .getMessages,
            .getChatMessages:
            return .get
        case .registerClient,
             .validateCodePsw,
             .requestPassword,
             .changuePassword,
             .personalData,
             .paymentData,
             .addressData,
             .validateCodeRegister,
             .signIn,
             .order,
             .claimData,
             .setConectDisconect,
             .setUpdateCoordinate,
             .updateColorTankTruck,
             .acceptOrder,
             .changeStatusOrder,
             .changeDataAccount,
             .cancelOrder,
             .sendMessage,
             .sendChatMessage:
            return .post
        }
    }
    
    
    //  URL path
    var endpoint: String {
        switch self {
        case .signIn:
            return "mv/conductor/login"
        case .registerClient:
            return "mv/cliente/registrar"
        case .validateCodeRegister(let code):
            Router.codeValue = code.code
            return "verifica/\(Router.codeValue ?? "")"
        case .validateCodePsw:
            return "mv/cliente/password/validar"
        case .help:
            return "catalogos/tiposaclaracion/1"
        case .requestPassword:
            return "mv/conductor/password/solicitar"
        case .changuePassword:
            return "mv/cliente/password/cambiar"
        case .personalData:
            return "mv/cliente/actualizar"
        case .paymentData:
            return "mv/cliente/formapago/registrar"
        case .addressData:
            return "mv/cliente/direccion/agregar"
        case .bankData(let bin):
            return "mv/cliente/banco/\(bin)"
        case .clientStatus:
            return "mv/cliente/status"
        case .searchZC(let code):
            Router.codeValue = code.code
            return "mv/cliente/asentamientos/\(Router.codeValue ?? "")"
        case .addressConsult:
            return "mv/cliente/direcciones"
        //case .mainSearch(let values):
        //    return "mv/cliente/autotanques/disponibles?latitud=\(values.lat)&longitud=\(values.lon)"
        case .mainSearch:
            return "mv/cliente/autotanques/disponibles"
        case .order:
            return "mv/cliente/pedido/solicitar"
        case .cancelReason:
            return "catalogos/motivoscancelacion/2"
        case .cancelOrder:
            return "mv/conductor/pedido/cancelar"
        // Conductor
        case .getOrder(let idPedido):
            return "mv/conductor/pedido/obtener/\(idPedido.idPedido)"
        case .setConectDisconect:
            return "mv/conductor/conectar"
        case .setUpdateCoordinate:
            return "mv/conductor/actualizarubicacion"
        case .acceptOrder:
            return "mv/conductor/aceptarpedido"
        case .changeStatusOrder:
            return "mv/conductor/actualizarpedido"
        case .getQualifications:
            return "mv/conductor/porcentajes"
        case .getComments:
            return "mv/conductor/calificaciones"
        case .getHistorical:
            return "mv/conductor/pedido/obtener"
        case .getBanks:
            return "catalogos/bancos"
        case .getWeeks:
            return "catalogos/semanas"
        case .getBoardData(let idWeek):
            return "mv/conductor/tablero/\(idWeek.idWeek)"
        case .getDocumentsData(let idConductor):
            return "mv/conductor/archivo/\(idConductor.idConductor)"
        case .getTankTruck:
            return "mv/conductor/autotanque"
        case .updateColorTankTruck:
            return "mv/conductor/autotanque/editar"
        case .getSalesReport(let pType):
            return "reportes/montoventa/\(pType.pType)"
        case .getLitersReport(let pType):
            return "reportes/cantidadventa/\(pType.pType)"
        case .getAccountData(let idConductor):
            return "mv/conductor/cuenta/\(idConductor.idConductor)"
        case .changeDataAccount:
            return "mv/conductor/cuenta/actualizar"
            
        case .claimType:
            return "catalogos/tiposaclaracion/1"
        case .claimData:
            return "aclaracion/agregar"
        case .consultAsk:
            return "aclaracion/preguntas"
        case .faqList(let param):
            return "catalogos/preguntas/\(param.id)"
        case .getMessages(let param):
            return "aclaracion/seguimiento/obtener/\(param.id)"
        case .sendMessage:
            return "aclaracion/seguimiento/agregar"
        case .getChatMessages(let param):
            return "chat/obtener/\(param.id)"
        case .sendChatMessage:
            return "chat/agregar"
            
        }
        
        
    }
    
    
    
    // URLRequestConvertible
    
    
    func asURLRequest() throws -> URLRequest {
        
        // BaseURL string
        let url = try Router.baseURLString.asURL()
        
        // URLRequest
        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint))
        
        // Set HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        
        
        //Set timeout
        //urlRequest.timeoutInterval = TimeInterval(10 * 1000)
        switch self {
             
        case.signIn(let parameters),
            .registerClient(let parameters),
            .requestPassword(let parameters),
            .changuePassword(let parameters):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
            //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            debugPrint("PARAMETERS__________-")
            debugPrint(parameters)
            
        case.validateCodePsw(let parameters):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
                       //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
                       urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                       debugPrint("PARAMETERS__________-")
                       debugPrint(parameters)
            
        case.mainSearch(let autorizathionToken, let parameters),
            .cancelOrder(let autorizathionToken, let parameters),
            .acceptOrder(let autorizathionToken, let parameters),
            .changeStatusOrder(let autorizathionToken, let parameters),
            .updateColorTankTruck(let autorizathionToken, let parameters),
            .setUpdateCoordinate(let autorizathionToken, let parameters),
            
            .setConectDisconect(let autorizathionToken, let parameters):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
            //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            debugPrint("PARAMETERS__________-")
            debugPrint(parameters)
            
        case.personalData(let autorizathionToken, let parametersSet),
            .addressData(let autorizathionToken, let parametersSet),
            .paymentData(let autorizathionToken, let parametersSet),
            .changeDataAccount(let autorizathionToken, let parametersSet),
            .order(let autorizathionToken, let parametersSet),
            .claimData(let autorizathionToken, let parametersSet),
            .sendMessage(let autorizathionToken, let parametersSet),
            .sendChatMessage(let autorizathionToken, let parametersSet):
            //request post JSON
            
            let data = try! JSONSerialization.data(withJSONObject: parametersSet, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       if let json = json {
                           print(json)
                       }
           
            urlRequest = try Alamofire.URLEncoding.httpBody.encode(urlRequest, with: [:])
            urlRequest.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            debugPrint("PARAMETERS__________-")
            debugPrint(parametersSet)
            
            
        case.validateCodeRegister(let autorizathionToken, _),
            .searchZC(let autorizathionToken, _),
            .faqList(let autorizathionToken, _),
            .getMessages(let autorizathionToken, _),
            .getChatMessages(let autorizathionToken, _):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with:nil)
            //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            
        case.bankData(let autorizathionToken, _):
                   // Set encode to application/x-www-form-urlencoded
                   urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
                   urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                   urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            
            
        case.clientStatus(let autorizathionToken),
            .addressConsult(let autorizathionToken),
            .consultAsk(let autorizathionToken),
            .help(let autorizathionToken),
            .claimType(let autorizathionToken),
            .cancelReason(let autorizathionToken):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")

        case .getQualifications(let autorizathionToken),
             .getHistorical(let autorizathionToken),
             .getWeeks(let autorizathionToken),
             .getBanks(let autorizathionToken),
             .getTankTruck(let autorizathionToken),
             .getComments(let autorizathionToken):
        
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: nil)
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
        //****** Conductor
        case .getOrder(let autorizathionToken, _),
             .getDocumentsData(let autorizathionToken, _),
             .getAccountData(let autorizathionToken, _),
             .getBoardData(let autorizathionToken, _):
            // Set encode to application/x-www-form-urlencoded
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            
            //****** Conductor
        case .getSalesReport(let autorizathionToken, let parametersSet,let pContenttype, _),
             .getLitersReport(let autorizathionToken, let parametersSet,let pContenttype, _):
                // Set encode to application/x-www-form-urlencoded
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parametersSet)
                print("\(urlRequest)")
                urlRequest.setValue(pContenttype, forHTTPHeaderField: "Content-Type")
                urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
                
            
        }
        
        return urlRequest
    }
}
