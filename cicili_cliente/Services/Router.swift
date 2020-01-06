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
    case validate
    case help
    case requestPassword(with: Parameters)
    
    
    // HTTP method
       
    var method: HTTPMethod {
        switch self {
        case .help:
            return .get
        case .registerClient,
             .validate,
             .requestPassword,
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
        case .validate:
            return "verifica/"
        case .help:
            return "catalogos/tiposaclaracion/1"
        case .requestPassword:
            return "mv/cliente/password/solicitar"
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
        case.validate,
             .help:
            // Set encode to application/x-www-form-urlencoded
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        
        case.signIn(let parameters),
            .registerClient(let parameters),
            .requestPassword(let parameters):
            urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
            urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            debugPrint("PARAMETERS__________-")
            debugPrint(parameters)
        }
        
        return urlRequest
    }
}
