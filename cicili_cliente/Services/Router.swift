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
    
    case signIn(with: Parameters)
    case registerClient(with: Parameters)
    case validateCodePsw(with: Parameters)
    case validateCode
    case help
    case requestPassword(with: Parameters)
    case changuePassword(with: Parameters)
    case personalData(with: Parameters)
    
    
    // HTTP method
       
    var method: HTTPMethod {
        switch self {
        case.help,
            .validateCode:
            return .get
        case .registerClient,
             .validateCodePsw,
             .requestPassword,
             .changuePassword,
             .personalData,
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
        case .validateCode:
            return "verifica"
        case .validateCodePsw:
            return "mv/cliente/password/validar/"
        case .help:
            return "catalogos/tiposaclaracion/1"
        case .requestPassword:
            return "mv/cliente/password/solicitar"
        case .changuePassword:
            return "mv/cliente/password/cambiar"
        case .personalData:
            return "mv/cliente/actualizar"
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
        case.validateCode,
            .help:
            // Set encode to application/x-www-form-urlencoded
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        
        case.signIn(let parameters),
            .registerClient(let parameters),
            .requestPassword(let parameters),
            .validateCodePsw(let parameters),
            .personalData(let parameters),
            .changuePassword(let parameters):
            urlRequest = try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
            //urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            //debugPrint("PARAMETERS__________-")
            //debugPrint(parameters)
    
        }
        
        return urlRequest
    }
}
