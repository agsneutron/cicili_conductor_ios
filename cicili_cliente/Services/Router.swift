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
    case help
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
    
    
    // HTTP method
       
    var method: HTTPMethod {
        switch self {
        case.help,
            .clientStatus,
            .searchZC,
            .bankData,
            .addressConsult,
            .mainSearch:
            return .get
        case .registerClient,
             .validateCodePsw,
             .requestPassword,
             .changuePassword,
             .personalData,
             .paymentData,
             .addressData,
             .validateCodeRegister,
             .signIn:
            return .post
        }
    }
    
    
    //  URL path
    var endpoint: String {
        switch self {
        case .signIn:
            return "mv/cliente/login"
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
            return "mv/cliente/password/solicitar"
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
        case.help:
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
             
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
            
        case.mainSearch(let autorizathionToken, let parameters):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
            //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            debugPrint("PARAMETERS__________-")
            debugPrint(parameters)
            
        case.personalData(let autorizathionToken, let parametersSet),
            .addressData(let autorizathionToken, let parametersSet),
            .paymentData(let autorizathionToken, let parametersSet):
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
            .searchZC(let autorizathionToken, _):
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
            .addressConsult(let autorizathionToken):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            urlRequest.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(autorizathionToken, forHTTPHeaderField: "Authorization")
        
            
        }
        
        return urlRequest
    }
}
