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
        
        // Alamofire.request("http://34.66.139.244:8080/app/mv/cliente/login",
        //       method: .post,
        //       parameters: parameters,
        //       encoding: URLEncoding(destination: .queryString)).responseJSON{
        //      response in
        //          print("*********RESPONSE***************")
        //          debugPrint(response)
                
                
        // Fetch request
        Alamofire.request(Router.signIn(with: parameters)).responseJSON{
       response in
        //print("*********RESPONSE***************")
        //debugPrint(response)
        //print("**********RESULT**************")
        //debugPrint(response.result)
        //print("************RESULT value************")
        //debugPrint(response.result.value)
            
           switch response.result {
           case .success:
            let json = JSON(response.result.value!)
                //print("JSON message: \(json[WSKeys.parameters.messageError])")
                //print("JSON data: \(json[WSKeys.parameters.data])")
                //print("JSON error: \(json[WSKeys.parameters.error])")
            let errorcode: Int = json[WSKeys.parameters.error].intValue
            let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
            let cliente_data = json[WSKeys.parameters.data].dictionaryObject
            //print("*********CLIENTE DATA***************")
            //debugPrint(cliente_data)
            let cliente = Mapper<Cliente>().map( JSONObject: cliente_data)
            //print("*********CLIENTE RESULT***************")
            //debugPrint(cliente?.token! as Any)
            if errorcode == WSKeys.parameters.okresponse, cliente?.token != nil{
                success(cliente!)
            } else {
                failure(NSError(domain: "com.cicili.signin", code: errorcode, userInfo: [NSLocalizedDescriptionKey: messagedescription]))
            }
            
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    //for request Password forgotten
    class func fetchRequestPassword(parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.requestPassword(with: parameters)).responseObject { (response: DataResponse<Response>) in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            if objectResponse!.codeError == WSKeys.parameters.okresponse {
                success(objectResponse!)
                //.responseJSON{
                //response in
                //  switch response.result {
                // case .success:
                // let json = JSON(response.result.value!)
                // let errorcode: Int = json[WSKeys.parameters.error].intValue
                //let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
                //let cliente = Mapper<Cliente>().map(JSONString: json[WSKeys.parameters.data].stringValue)
                //if errorcode == WSKeys.parameters.okresponse, cliente?.token != nil{
                //    success(cliente!)
            } else {
                failure(NSError(domain: "com.cicili.requestpassword", code: (objectResponse?.codeError.hashValue)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    
    //for registes client
    class func fetchRegisterClient(parameters: Parameters, success: @escaping (Cliente) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.registerClient(with: parameters)).responseObject { (response: DataResponse<Cliente>) in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
                //print("JSON message: \(json[WSKeys.parameters.messageError])")
                //print("JSON data: \(json[WSKeys.parameters.data])")
                //print("JSON error: \(json[WSKeys.parameters.error])")
            let errorcode: Int = json[WSKeys.parameters.error].intValue
            let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
            let cliente_data = json[WSKeys.parameters.data].dictionaryObject
            //print("*********CLIENTE DATA***************")
            //debugPrint(cliente_data)
            let cliente = Mapper<Cliente>().map( JSONObject: cliente_data)
            //print("*********CLIENTE RESULT***************")
            //debugPrint(cliente?.token! as Any)
            if errorcode == WSKeys.parameters.okresponse, cliente?.token != nil{
             
                success(cliente!)
            
            } else {
                failure(NSError(domain: "com.cicili.RegisterClient", code: (errorcode), userInfo: [NSLocalizedDescriptionKey: messagedescription ]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    //for verify password
    class func fetchValidateCodePassword(parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
           
           // Fetch request
        Alamofire.request(Router.validateCodePsw(with: parameters)).responseObject { (response: DataResponse<Response>) in
           
               debugPrint("*********RES*********")
               debugPrint(response)
           // Evalute result
           switch response.result {
           case .success:
               let objectResponse = response.result.value
               
               if objectResponse!.codeError == WSKeys.parameters.okresponse {
                   
                   success(objectResponse!)
               
               } else {
                   failure(NSError(domain: "com.cicili.validateCodePassword", code: (objectResponse?.codeError.hashValue)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
               }
              case .failure(let error):
                  failure(error as NSError)
              }
           }
       }
    
    
    //for changue password
    
    class func fetchChanguePassword(parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
     Alamofire.request(Router.changuePassword(with: parameters)).responseObject { (response: DataResponse<Response>) in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            
            if objectResponse!.codeError == WSKeys.parameters.okresponse {
                
                success(objectResponse!)
            
            } else {
                failure(NSError(domain: "com.cicili.changuePassword", code: (objectResponse?.codeError.hashValue)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    //to save PersonalData
    class func setPersonalData(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.personalData(autorizathionToken: oauthToken , parametersSet: parameters)).responseObject { (response: DataResponse<Response>) in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            
            if objectResponse!.codeError.hashValue == WSKeys.parameters.okresponse {
                
                success(objectResponse!)
            
            } else {
                failure(NSError(domain: "com.cicili.PersonalData", code: (objectResponse?.codeError.hashValue)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    //to paymentdata
    class func setPaymentData(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.paymentData(autorizathionToken: oauthToken , parametersSet: parameters)).responseObject { (response: DataResponse<Response>) in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            
            debugPrint("*********RES VALUE*********")
            debugPrint(objectResponse)
            
            debugPrint("*********RES VALUE*********")
            debugPrint(response.data)
            
            if objectResponse!.codeError == WSKeys.parameters.okresponse {
                
                success(objectResponse!)
            
            } else {
                failure(NSError(domain: "com.cicili.PaymentData", code: (objectResponse?.codeError)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    
    //let address data
    
    class func setAddressData(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.addressData(autorizathionToken: oauthToken , parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            let json = JSON(response.result.value!)
            debugPrint("*********RES VALUE*********")
            debugPrint(objectResponse)
            debugPrint("*********RES json*********")
            debugPrint(json)
           
            if response.response?.statusCode == WSKeys.parameters.statuscode {
                let addressResponse = Mapper<Response>().map( JSONObject: json["data"])
                success(addressResponse!)
            } else {
                failure(NSError(domain: "com.cicili.AddressData", code: (response.response?.statusCode)!, userInfo: [NSLocalizedDescriptionKey: json["error"].stringValue ]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    //to validatecoderegister
    
    class func fetchValidateCodeRegister(oauthToken: String, codeToVerify: String, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
           
           // Fetch request
        Alamofire.request(Router.validateCodeRegister(autorizathionToken: oauthToken , code:codeToVerify)).responseJSON{
           response in
           
               debugPrint("*********RES*********")
               debugPrint(response)
           // Evalute result
           switch response.result {
           case .success:
               let objectResponse = response.result.value
               let json = JSON(response.result.value!)
               debugPrint("*********RES VALUE*********")
               debugPrint(objectResponse)
               debugPrint("*********RES json*********")
               debugPrint(json)
              
               if response.response?.statusCode == WSKeys.parameters.statuscode {
                   let addressResponse = Mapper<Response>().map( JSONObject: json["data"])
                   success(addressResponse!)
               } else {
                   failure(NSError(domain: "com.cicili.AddressData", code: (response.response?.statusCode)!, userInfo: [NSLocalizedDescriptionKey: json["error"].stringValue ]))
               }
              case .failure(let error):
                  failure(error as NSError)
              }
           }
       }
}


