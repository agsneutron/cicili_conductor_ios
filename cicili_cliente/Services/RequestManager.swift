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
    
    class func fetchSignIn(parameters: Parameters, success: @escaping(Cliente) -> Void, failure: @escaping (NSError ->Void){
        
        //request
        switch respose.reult {
        case .success:
            if let user = response.result.value, user.accessToken != nil{
                success(user)
            }else{
                failure(NSError(domain: "com.cicili.signin", code: 100, userInfo: [NSLocalizedDescriptionKey: "El usuario no pudo ser "]))
            }
        
        case .failure(let error):
            fsilure(error as NDError)
        }
    }
}
