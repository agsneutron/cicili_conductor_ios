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
import SwiftyJSON

class RequestManager: NSObject{
    
    // for signin
    
    class func fetchSignIn(parameters: Parameters, success: @escaping (Cliente) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.signIn(with: parameters)).responseJSON{
       response in
           // print("*********RESPONSE***************")
           // debugPrint(response)
           // print("**********RESULT**************")
           // debugPrint(response.result)
           // print("************RESULT value************")
           // debugPrint(response.result.value)
            
           switch response.result {
           case .success:
            let json = JSON(response.result.value!)
                //print("JSON message: \(json[WSKeys.parameters.messageError])")
                //print("JSON data: \(json[WSKeys.parameters.data])")
                //print("JSON error: \(json[WSKeys.parameters.error])")
            let errorcode: Int = json[WSKeys.parameters.error].intValue
            let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
            let cliente = Mapper<Cliente>().map(JSONString: json[WSKeys.parameters.data].stringValue)
            if errorcode == WSKeys.parameters.okresponse, cliente?.token != nil{
                success(cliente!)
            } else {
                failure(NSError(domain: "com.puebla.signin", code: errorcode, userInfo: [NSLocalizedDescriptionKey: messagedescription]))
            }
            
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
}
