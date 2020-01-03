//
//  RequestManager.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 02/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class RequestManager: NSObject{
    
    // for signin
    
    class func fetchSignIn(parameters: Parameters, success: @escaping(Cliente) -> Void, failure: @escaping (NSError) ->Void){
        
        // Fetch request
        Alamofire.request(Router.signIn(with: parameters)).responseObject { (response: DataResponse<Cliente>) in
            
            // Evalute result
            switch response.result {
            case .success:
                
                if let user = response.result.value,  user.token != nil{
                    success(user)
                } else {
                    failure(NSError(domain: "com.cicili.signin", code: 100, userInfo: [NSLocalizedDescriptionKey: "El usuario no pudo ser indentificado"]))
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
}
