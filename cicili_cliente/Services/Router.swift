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
    
    case signIn(with: Parameters)
    case register
    case validate
    
    
    // HTTP method
       
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .get
        case .register,
             .validate:
            return .post
        }
    }
    
    
    //  URL path
    var endpoint: String {
        switch self {
        case .signIn:
            return "app/mv/cliente/login"
        case .register:
            return "app/mv/cliente/registrar"
        case .validate:
            return "app/verifica/"
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
        
        switch self {
        case .register,
             .validate:
            
            // Set encode to application/x-www-form-urlencoded
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        
        case.signIn(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
