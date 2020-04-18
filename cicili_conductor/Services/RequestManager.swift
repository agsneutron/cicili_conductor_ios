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
            print("*********CLIENTE DATA***************")
            debugPrint(cliente_data)
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
        Alamofire.request(Router.registerClient(with: parameters)).responseJSON{
        response in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
                //print("JSON message: \(json[WSKeys.parameters.messageError])")
                //print("JSON data: \(json[WSKeys.parameters.data])")
                //print("JSON error: \(json[WSKeys.parameters.error])")
            let errorcode =  json[WSKeys.parameters.error].intValue
                
            let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
            let cliente_data = json[WSKeys.parameters.data].dictionaryObject
            //print("*********CLIENTE DATA***************")
            //debugPrint(cliente_data)
            let cliente = Mapper<Cliente>().map( JSONObject: cliente_data)
            //print("*********CLIENTE RESULT***************")
            //debugPrint(cliente?.token! as Any)
            if errorcode == WSKeys.parameters.okresponse{
             
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
            
            if objectResponse!.codeError == WSKeys.parameters.okresponse {
                
                success(objectResponse!)
            
            } else {
                failure(NSError(domain: "com.cicili.PersonalData", code: (objectResponse?.codeError)!, userInfo: [NSLocalizedDescriptionKey: objectResponse?.messageError! ?? "ERROR"]))
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
        
            //debugPrint("*********RES*********")
            //debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let objectResponse = response.result.value
            let json = JSON(response.result.value!)
            //debugPrint("*********RES VALUE*********")
            //debugPrint(objectResponse)
            //debugPrint("*********RES json*********")
            //debugPrint(json)
           
            if response.response?.statusCode == WSKeys.parameters.statuscode {
                let addressResponse = Mapper<Response>().map( JSONObject: json["data"].dictionaryObject)
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
    
    class func fetchValidateCodeRegister(parameters: Parameters, success: @escaping (Cliente) -> Void, failure: @escaping (NSError) -> Void){
           
           // Fetch request
        Alamofire.request(Router.validateCodeRegister(with: parameters)).responseJSON{
        response in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            
            let json = JSON(response.result.value!)
            print("json ", json)
            let errorcode =  json[WSKeys.parameters.error].intValue
                
            let messagedescription: String = json[WSKeys.parameters.messageError].stringValue
            let cliente_data = json[WSKeys.parameters.data].dictionaryObject
            let cliente = Mapper<Cliente>().map( JSONObject: cliente_data)
            if errorcode == WSKeys.parameters.okresponse{
             
                success(cliente!)
            
            } else {
                failure(NSError(domain: "com.cicili.RegisterClient", code: (errorcode), userInfo: [NSLocalizedDescriptionKey: messagedescription ]))
            }
           case .failure(let error):
               failure(error as NSError)
           }
        }
            
       /* Alamofire.request(Router.validateCodeRegister(with: parameters)).responseObject { (response: DataResponse<Response>) in
           
               debugPrint("*********RES*********")
               debugPrint(response)
           switch response.result {
           case .success:
                let objectResponse = response.result.value
                debugPrint("*********RES VALUE*********")
                debugPrint(objectResponse?.data)
            
                if objectResponse?.codeError == WSKeys.parameters.okresponse {
                    debugPrint("fetchValidateCodeRegister")
                    success(objectResponse!)
                    
                } else {
                    failure(NSError(domain: "com.cicili.VerifyCodeData", code: objectResponse!.codeError, userInfo: [NSLocalizedDescriptionKey: objectResponse!.messageError ?? ""]))
               }
        case .failure(let error):
            failure(error as NSError)
            }
        }*/
    }
    
    //get bank data
    
    
    class func fetchBankData(oauthToken: String, binToVerify: String, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
     Alamofire.request(Router.bankData(autorizathionToken: oauthToken , bin: binToVerify)).responseJSON{
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
                success(objectResponse as! Response)
            } else {
                failure(NSError(domain: "com.cicili.BankData", code: (response.response?.statusCode)!, userInfo: [NSLocalizedDescriptionKey: json["error"].stringValue ]))
            }
            
            
           case .failure(let error):
               failure(error as NSError)
           }
        }
    }
    
    
    //get client status
    class func fetchClientStatus(oauthToken: String, success: @escaping (Status) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.clientStatus(autorizathionToken: oauthToken)).responseJSON{
           response in
           
            debugPrint("*********RES*********")
            debugPrint(response)
            // Evalute result
            switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    debugPrint("*********RES json*********")
                    debugPrint(json)
                   
                    let errorcode: Int = json[WSKeys.parameters.error].intValue
                 
                    if errorcode == WSKeys.parameters.okresponse {
                        let responseData = json[WSKeys.parameters.data].dictionaryObject
                        let statusObject = Mapper<Status>().map( JSONObject: responseData)
                        success(statusObject!)
                   } else {
                       failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    
    //search zipCode
    class func fetchZipCode(oauthToken: String, codeToVerify: String, success: @escaping (DataByZipCode) -> Void, failure: @escaping (NSError) -> Void){
           
           // Fetch request
        Alamofire.request(Router.searchZC(autorizathionToken: oauthToken , code:codeToVerify)).responseJSON{
        response in
        
             // Evalute result
             switch response.result {
                 case .success:
                     let json = JSON(response.result.value!)
                    
                     let errorcode: Int = json[WSKeys.parameters.error].intValue
                     if errorcode == WSKeys.parameters.okresponse {
                         let responseData = json[WSKeys.parameters.data].dictionaryObject
                         let statusObject = Mapper<DataByZipCode>().map( JSONObject: responseData)
                         success(statusObject!)
                    } else {
                        failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                    }
                 case .failure(let error):
                     failure(error as NSError)
             }
        }
    }
    
    //get address consult
    class func fetchAddressConsult(oauthToken: String, success: @escaping ([Address]) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.addressConsult(autorizathionToken: oauthToken)).responseJSON{
           response in
           
            // Evalute result
            switch response.result {
                case .success:
                   
                    let json = JSON(response.result.value!)

                    
                    let errorcode: Int = json[WSKeys.parameters.error].intValue
                 
                    if errorcode == WSKeys.parameters.okresponse {
                        let responseData = json[WSKeys.parameters.data].arrayObject
                        let statusObject = Mapper<Address>().mapArray(JSONArray: responseData as! [[String : Any]])
                        success(statusObject)
                   } else {
                       failure(NSError(domain: "com.cicili.AddressConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    //get main consult
    class func fetchMainSearch(oauthToken: String,  parameters: Parameters, success: @escaping ([NearDrivers]) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.mainSearch(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
           response in
           
            // Evalute result
            switch response.result {
                case .success:
                   
                    let json = JSON(response.result.value!)

                    let errorcode: Int = json[WSKeys.parameters.error].intValue
                 
                    if errorcode == WSKeys.parameters.okresponse {
                        let responseData = json[WSKeys.parameters.data].arrayObject
                        let statusObject = Mapper<NearDrivers>().mapArray(JSONArray: responseData as! [[String : Any]])
                        success(statusObject)
                   } else {
                       failure(NSError(domain: "com.cicili.MainSearchData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    //to order
    //
    class func setOrderData(oauthToken: String, parameters: Parameters, success: @escaping (NewOrder) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.order(autorizathionToken: oauthToken , parametersSet: parameters)).responseJSON{
        response in

        // Evalute result
        switch response.result {
        case .success:
           let json = JSON(response.result.value!)

            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json[WSKeys.parameters.data].dictionaryObject
                let statusObject = Mapper<NewOrder>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
           
        case .failure(let error):
            failure(error as NSError)
        }
    }
    }
    
    //get cancel reason
       class func fetchCancelReason(oauthToken: String, success: @escaping ([ReusableIdText]) -> Void, failure: @escaping (NSError) -> Void){
              // Fetch request
           Alamofire.request(Router.cancelReason(autorizathionToken: oauthToken)).responseJSON{
              response in
              
               debugPrint("*********RES cancel reazons*********")
               debugPrint(response)
               // Evalute result
               switch response.result {
                   case .success:
                       let json = JSON(response.result.value!)
                       debugPrint("*********RES json*********")
                       debugPrint(json)
                      
                       let errorcode: Int = json[WSKeys.parameters.error].intValue
                    
                       if errorcode == WSKeys.parameters.okresponse {
                           let responseData = json[WSKeys.parameters.data].arrayObject
                           let statusObject = Mapper<ReusableIdText>().mapArray(JSONArray: responseData as! [[String : Any]])
                           success(statusObject)
                      } else {
                          failure(NSError(domain: "com.cicili.CancelReason", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                      }
                   case .failure(let error):
                       failure(error as NSError)
               }
           }
       }
    
    
    //*********************************************************************************
    
    class func getOrderData(oauthToken: String, idPedido: String, success: @escaping (ResponseOrder) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getOrder(autorizathionToken: oauthToken, idPedido: idPedido)).responseJSON{
        response in
            
            debugPrint("*********RES cancel getOrderData *********")
            debugPrint(response)

        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json[WSKeys.parameters.data].dictionaryObject
                let statusObject = Mapper<ResponseOrder>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func getBoardData(oauthToken: String, idWeek: String, success: @escaping ([NewOrder]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getBoardData(autorizathionToken: oauthToken, idWeek: idWeek)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
               let errorcode: Int = json[WSKeys.parameters.error].intValue
            
               if errorcode == WSKeys.parameters.okresponse {
                   let responseData = json[WSKeys.parameters.data].arrayObject
                   let statusObject = Mapper<NewOrder>().mapArray(JSONArray: responseData as! [[String : Any]])
                   
                   success(statusObject)
              } else {
                  failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
              }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func getDocumentsData(oauthToken: String, idConductor: String, success: @escaping ([DocumentsData]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getDocumentsData(autorizathionToken: oauthToken, idConductor: idConductor)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
               debugPrint("*********RES json getDocumentsData*********")
               debugPrint(json)
              
               let errorcode: Int = json[WSKeys.parameters.error].intValue
            
               if errorcode == WSKeys.parameters.okresponse {
                   let responseData = json[WSKeys.parameters.data].arrayObject
                   let statusObject = Mapper<DocumentsData>().mapArray(JSONArray: responseData as! [[String : Any]])
                   
                   success(statusObject)
              } else {
                  failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
              }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    class func setConectDisconect(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.setConectDisconect(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********Pedido*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            debugPrint("*********JSON RES VALUE*********")
            debugPrint(json)
            
            debugPrint("*********RES DATA VALUE*********")
            debugPrint(json["data"])
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                debugPrint("*********statusObject VALUE*********")
                debugPrint("\(String(describing: responseData?.description))")
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func changeDataAccount(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.changeDataAccount(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                debugPrint("*********changeDataAccount VALUE*********")
                debugPrint("\(String(describing: responseData?.description))")
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func getQualifications(oauthToken: String, success: @escaping (ResponseData) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getQualifications(autorizathionToken: oauthToken)).responseJSON{
        response in
        
            debugPrint("*********getQualifications*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            debugPrint("*********JSON RES VALUE*********")
            debugPrint(json)
            
            debugPrint("*********RES DATA VALUE*********")
            debugPrint(json["data"])
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json["data"].dictionaryObject
                let statusObject = Mapper<ResponseData>().map( JSONObject: responseData)
                debugPrint("*********statusObject VALUE*********")
                debugPrint("\(String(describing: responseData?.description))")
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func isActiveOrder(oauthToken: String, success: @escaping (NewOrder) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.isActiveOrder(autorizathionToken: oauthToken)).responseJSON{
        response in
        print("isActiveOrder ", response)
        // Evalute result
        switch response.result {
            case .success:
               
                let json = JSON(response.result.value!)
                debugPrint("*********RES json*********")
                debugPrint(json)
                
                let errorcode: Int = json[WSKeys.parameters.error].intValue
             
                if errorcode == WSKeys.parameters.okresponse {
                    let responseData = json[WSKeys.parameters.data].dictionaryObject
                    let statusObject = Mapper<NewOrder>().map( JSONObject: responseData)
                    success(statusObject!)
               } else {
                   failure(NSError(domain: "com.cicili.AddressConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
               }
            case .failure(let error):
                failure(error as NSError)
        }
            
            
        }
    }
    
    class func getComments(oauthToken: String, success: @escaping ([CommentsData]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getComments(autorizathionToken: oauthToken)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
            case .success:
               
                let json = JSON(response.result.value!)
                debugPrint("*********RES json*********")
                debugPrint(json)
                
                let errorcode: Int = json[WSKeys.parameters.error].intValue
             
                if errorcode == WSKeys.parameters.okresponse {
                    let responseData = json[WSKeys.parameters.data].arrayObject
                    let statusObject = Mapper<CommentsData>().mapArray(JSONArray: responseData as! [[String : Any]])
                    success(statusObject)
               } else {
                   failure(NSError(domain: "com.cicili.AddressConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
               }
            case .failure(let error):
                failure(error as NSError)
        }
            
            
        }
    }
    
    class func getTankTruck(oauthToken: String, success: @escaping (TankTruckData) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getTankTruck(autorizathionToken: oauthToken)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
            case .success:
               
                let json = JSON(response.result.value!)
                debugPrint("*********getTankTruck json*********")
                debugPrint(json)
                
                let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                if errorcode == WSKeys.parameters.okresponse {
                    let responseData = json[WSKeys.parameters.data].dictionaryObject
                    let statusObject = Mapper<TankTruckData>().map( JSONObject: responseData)
                    success(statusObject!)
                } else {
                    failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                }
            case .failure(let error):
                failure(error as NSError)
        }
            
            
        }
    }
    
    class func getAccountData(oauthToken: String, idConductor: String, success: @escaping (AccountData) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getAccountData(autorizathionToken: oauthToken, idConductor: idConductor)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
            case .success:
               
                let json = JSON(response.result.value!)
                debugPrint("*********getAccountData json*********")
                debugPrint(json)
                
                let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                if errorcode == WSKeys.parameters.okresponse {
                    let responseData = json[WSKeys.parameters.data].dictionaryObject
                    let statusObject = Mapper<AccountData>().map( JSONObject: responseData)
                    success(statusObject!)
                } else {
                    failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                }
            case .failure(let error):
                failure(error as NSError)
        }
            
            
        }
    }
    
    class func getHistorical(oauthToken: String, success: @escaping ([NewOrder]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.getHistorical(autorizathionToken: oauthToken)).responseJSON{
        response in
        
        // Evalute result
        switch response.result {
            case .success:
               
                let json = JSON(response.result.value!)
                debugPrint("*********RES json*********")
                debugPrint(json)
                
                let errorcode: Int = json[WSKeys.parameters.error].intValue
             
                if errorcode == WSKeys.parameters.okresponse {
                    let responseData = json[WSKeys.parameters.data].arrayObject
                    let statusObject = Mapper<NewOrder>().mapArray(JSONArray: responseData as! [[String : Any]])
                    success(statusObject)
               } else {
                   failure(NSError(domain: "com.cicili.AddressConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
               }
            case .failure(let error):
                failure(error as NSError)
        }
            
            
        }
    }
    
    class func getWeeks(oauthToken: String, success: @escaping ([ReusableIdText]) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.getWeeks(autorizathionToken: oauthToken)).responseJSON{
           response in
           
            // Evalute result
            switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    debugPrint("*********RES json*********")
                    debugPrint(json)
                   
                    let errorcode: Int = json[WSKeys.parameters.error].intValue
                 
                    if errorcode == WSKeys.parameters.okresponse {
                        let responseData = json[WSKeys.parameters.data].arrayObject
                        let statusObject = Mapper<ReusableIdText>().mapArray(JSONArray: responseData as! [[String : Any]])
                        
                        success(statusObject)
                   } else {
                       failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    class func getBanks(oauthToken: String, success: @escaping ([ReusableIdText]) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.getBanks(autorizathionToken: oauthToken)).responseJSON{
           response in
           
            // Evalute result
            switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    debugPrint("*********RES banks json*********")
                    debugPrint(json)
                   
                    let errorcode: Int = json[WSKeys.parameters.error].intValue
                 
                    if errorcode == WSKeys.parameters.okresponse {
                        let responseData = json[WSKeys.parameters.data].arrayObject
                        let statusObject = Mapper<ReusableIdText>().mapArray(JSONArray: responseData as! [[String : Any]])
                        
                        success(statusObject)
                   } else {
                       failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    /*func getSalesReport(oauthToken: String) -> Void {
           // Fetch request
        var parametros: SalesParameters?
        parametros!.type = "xls"
        parametros!.initialDate = "01/01/2020"
        parametros!.endDate = "01/03/2020"
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("hola.xls")
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(Router.getSalesReport(autorizathionToken: oauthToken, pParameters: parametros!), to: destination).responseData { response in
            if let destinationUrl = response.destinationURL {
                print("destinationUrl \(destinationUrl.absoluteURL)")
            }
        }
        
        
    }*/
    
    class func setUpdateCoordinate(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.setUpdateCoordinate(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********update coordinate*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            debugPrint("*********JSON RES VALUE*********")
            debugPrint(json)
            
            debugPrint("*********RES DATA VALUE*********")
            debugPrint(json["data"])
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func updateColorTankTruck(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.updateColorTankTruck(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********update updateColorTankTruck*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func ChangeStatusOrder(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.changeStatusOrder(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********Pedido*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            debugPrint("*********JSON RES VALUE*********")
            debugPrint(json)
            
            debugPrint("*********RES DATA VALUE*********")
            debugPrint(json["data"])
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    
    class func acceptOrder(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.acceptOrder(autorizathionToken: oauthToken, parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********Pedido*********")
            debugPrint(response)
        // Evalute result
        switch response.result {
        case .success:
            let json = JSON(response.result.value!)
            
            debugPrint("*********JSON RES VALUE*********")
            debugPrint(json)
            
            debugPrint("*********RES DATA VALUE*********")
            debugPrint(json["data"])
            let errorcode: Int = json[WSKeys.parameters.error].intValue
                               
            if errorcode == WSKeys.parameters.okresponse {
                let responseData = json.dictionaryObject
                let statusObject = Mapper<Response>().map( JSONObject: responseData)
                success(statusObject!)
            } else {
                failure(NSError(domain: "com.cicili.ClientStatusData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
            }
        case .failure(let error):
               failure(error as NSError)
           }
            
            
        }
    }
    //*********************************************************************************
    
    //get cancel order
    class func setCancelOrder(oauthToken: String,  parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
           // Fetch request
        Alamofire.request(Router.cancelOrder(autorizathionToken: oauthToken, parametersSet: parameters)).responseObject { (response: DataResponse<Response>) in
           
            debugPrint("*********RES*********")
            debugPrint(response)
            // Evalute result
            switch response.result {
            case .success:
                 let objectResponse = response.result.value
                 debugPrint("*********RES VALUE*********")
                 debugPrint(objectResponse?.codeError as Any)
             
                 if objectResponse?.codeError == WSKeys.parameters.okresponse {
                     debugPrint("okresponse")
                     success(objectResponse!)
                     
                 } else {
                      failure(NSError(domain: "com.cicili.CancelData", code: objectResponse!.codeError, userInfo: [NSLocalizedDescriptionKey: objectResponse!.messageError ?? ""]))
                 }
                case .failure(let error):
                    failure(error as NSError)
            }
        }
    }
    
    //search ask
          class func fetchAsk(oauthToken: String, success: @escaping ([ClaimConsult]) -> Void, failure: @escaping (NSError) -> Void){
                    
                    // Fetch request
                 Alamofire.request(Router.consultAsk(autorizathionToken: oauthToken)).responseJSON{
                 response in
                 
                      debugPrint("*********RES*********")
                      debugPrint(response)
                      // Evalute result
                      switch response.result {
                          case .success:
                                           
                                            let json = JSON(response.result.value!)
                                            debugPrint("*********RES json oorders list*********")
                                            debugPrint(json)
                                            
                                            let errorcode: Int = json[WSKeys.parameters.error].intValue
                                         
                                            if errorcode == WSKeys.parameters.okresponse {
                                                let responseData = json[WSKeys.parameters.data].arrayObject
                                                let statusObject = Mapper<ClaimConsult>().mapArray(JSONArray: responseData as! [[String : Any]])
                                                success(statusObject)
                                           } else {
                                               failure(NSError(domain: "com.cicili.AskConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                                           }
                                        case .failure(let error):
                                            failure(error as NSError)
                          
                      }
                 }
             }
          
    
    //FAQ
    class func fetchFAQ(oauthToken: String, success: @escaping ([ReusableIdText]) -> Void, failure: @escaping (NSError) -> Void){
              
              // Fetch request
           Alamofire.request(Router.help(autorizathionToken: oauthToken)).responseJSON{
           response in
           
                debugPrint("*********RES*********")
                debugPrint(response)
                // Evalute result
                switch response.result {
                    case .success:
                                     
                                      let json = JSON(response.result.value!)
                                      debugPrint("*********RES json oorders list*********")
                                      debugPrint(json)
                                      
                                      let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                                      if errorcode == WSKeys.parameters.okresponse {
                                          let responseData = json[WSKeys.parameters.data].arrayObject
                                          let statusObject = Mapper<ReusableIdText>().mapArray(JSONArray: responseData as! [[String : Any]])
                                          success(statusObject)
                                     } else {
                                         failure(NSError(domain: "com.cicili.AskConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                                     }
                                  case .failure(let error):
                                      failure(error as NSError)
                    
                }
           }
       }
    
    //get faq list by cat
    class func fetchFAQList(oauthToken: String, id: String, success: @escaping ([FAQ]) -> Void, failure: @escaping (NSError) -> Void){
              
              // Fetch request
           Alamofire.request(Router.faqList(autorizathionToken: oauthToken , id:id)).responseJSON{
           response in
           
                debugPrint("*********RES*********")
                debugPrint(response)
                // Evalute result
                switch response.result {
                    case .success:
                                     
                                      let json = JSON(response.result.value!)
                                      debugPrint("*********RES json oorders list*********")
                                      debugPrint(json)
                                      
                                      let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                                      if errorcode == WSKeys.parameters.okresponse {
                                          let responseData = json[WSKeys.parameters.data].arrayObject
                                          let statusObject = Mapper<FAQ>().mapArray(JSONArray: responseData as! [[String : Any]])
                                          success(statusObject)
                                     } else {
                                         failure(NSError(domain: "com.cicili.CLaimConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                                     }
                                  case .failure(let error):
                                      failure(error as NSError)
                    
                }
           }
       }
    
    //get message listfor acl or ask
    class func fetchMessages(oauthToken: String, id: String, success: @escaping ([Message]) -> Void, failure: @escaping (NSError) -> Void){
              
              // Fetch request
           Alamofire.request(Router.getMessages(autorizathionToken: oauthToken , id:id)).responseJSON{
           response in
           
                debugPrint("*********RES*********")
                debugPrint(response)
                // Evalute result
                switch response.result {
                    case .success:
                                     
                                      let json = JSON(response.result.value!)
                                      debugPrint("*********RES json oorders list*********")
                                      debugPrint(json)
                                      
                                      let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                                      if errorcode == WSKeys.parameters.okresponse {
                                          let responseData = json[WSKeys.parameters.data].arrayObject
                                          let statusObject = Mapper<Message>().mapArray(JSONArray: responseData as! [[String : Any]])
                                          success(statusObject)
                                     } else {
                                         failure(NSError(domain: "com.cicili.GetMEssagesConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                                     }
                                  case .failure(let error):
                                      failure(error as NSError)
                    
                }
           }
       }
    
    //sendmessage
    class func setMessage(oauthToken: String, parameters: Parameters, success: @escaping ([Message]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.sendMessage(autorizathionToken: oauthToken , parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
            switch response.result {
            case .success:
               let json = JSON(response.result.value!)
                
                debugPrint("*********JSON RES VALUE*********")
                debugPrint(json)
                
                debugPrint("*********RES DATA VALUE*********")
                debugPrint(json["data"])
                let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                if errorcode == WSKeys.parameters.okresponse {
                   let responseData = json[WSKeys.parameters.data].arrayObject
                    let statusObject = Mapper<Message>().mapArray(JSONArray: responseData as! [[String : Any]])
                    success(statusObject)
                } else {
                    failure(NSError(domain: "com.cicili.NewMessageData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                }
               
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    //get message listfor acl or ask
    class func fetchChatMessages(oauthToken: String, id: String, success: @escaping ([Message]) -> Void, failure: @escaping (NSError) -> Void){
              
              // Fetch request
           Alamofire.request(Router.getChatMessages(autorizathionToken: oauthToken , id:id)).responseJSON{
           response in
           
                debugPrint("*********RES*********")
                debugPrint(response)
                // Evalute result
                switch response.result {
                    case .success:
                                     
                                      let json = JSON(response.result.value!)
                                      debugPrint("*********RES json oorders list*********")
                                      debugPrint(json)
                                      
                                      let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                                      if errorcode == WSKeys.parameters.okresponse {
                                          let responseData = json[WSKeys.parameters.data].arrayObject
                                          let statusObject = Mapper<Message>().mapArray(JSONArray: responseData as! [[String : Any]])
                                          success(statusObject)
                                     } else {
                                         failure(NSError(domain: "com.cicili.GetMEssagesConsultData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                                     }
                                  case .failure(let error):
                                      failure(error as NSError)
                    
                }
           }
       }
    
    //sendmessage
    class func setChatMessage(oauthToken: String, parameters: Parameters, success: @escaping ([Message]) -> Void, failure: @escaping (NSError) -> Void){
        
        // Fetch request
        Alamofire.request(Router.sendChatMessage(autorizathionToken: oauthToken , parametersSet: parameters)).responseJSON{
        response in
        
            debugPrint("*********RES*********")
            debugPrint(response)
        // Evalute result
            switch response.result {
            case .success:
               let json = JSON(response.result.value!)
                
                debugPrint("*********JSON RES VALUE*********")
                debugPrint(json)
                
                debugPrint("*********RES DATA VALUE*********")
                debugPrint(json["data"])
                let errorcode: Int = json[WSKeys.parameters.error].intValue
                                   
                if errorcode == WSKeys.parameters.okresponse {
                   let responseData = json[WSKeys.parameters.data].arrayObject
                    let statusObject = Mapper<Message>().mapArray(JSONArray: responseData as! [[String : Any]])
                    success(statusObject)
                } else {
                    failure(NSError(domain: "com.cicili.NewMessageData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                }
               
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    
    //get claims categories
    class func fetchClaimType(oauthToken: String, success: @escaping ([ReusableIdText]) -> Void, failure: @escaping (NSError) -> Void){
              // Fetch request
           Alamofire.request(Router.claimType(autorizathionToken: oauthToken)).responseJSON{
              response in
              
               debugPrint("*********RES*********")
               debugPrint(response)
               // Evalute result
               switch response.result {
                   case .success:
                       let json = JSON(response.result.value!)
                       debugPrint("*********RES json*********")
                       debugPrint(json)
                      
                       let errorcode: Int = json[WSKeys.parameters.error].intValue
                    
                       if errorcode == WSKeys.parameters.okresponse {
                           let responseData = json[WSKeys.parameters.data].arrayObject
                                                  let statusObject = Mapper<ReusableIdText>().mapArray(JSONArray: responseData as! [[String : Any]])
                                                  success(statusObject)
                      } else {
                          failure(NSError(domain: "com.cicili.ClaimType", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                      }
                   case .failure(let error):
                       failure(error as NSError)
               }
           }
       }
    
    //to add claim
       class func setClaimData(oauthToken: String, parameters: Parameters, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void){
           
           // Fetch request
           Alamofire.request(Router.claimData(autorizathionToken: oauthToken , parametersSet: parameters)).responseJSON{
           response in
           
               debugPrint("*********RES*********")
               debugPrint(response)
           // Evalute result
               switch response.result {
               case .success:
                  let json = JSON(response.result.value!)
                   
                   debugPrint("*********JSON RES VALUE*********")
                   debugPrint(json)
                   
                   debugPrint("*********RES DATA VALUE*********")
                   debugPrint(json["data"])
                   let errorcode: Int = json[WSKeys.parameters.error].intValue
                                      
                   if errorcode == WSKeys.parameters.okresponse {
                       let responseData = json[WSKeys.parameters.data].dictionaryObject
                       let statusObject = Mapper<Response>().map( JSONObject: responseData)
                       success(statusObject!)
                   } else {
                       failure(NSError(domain: "com.cicili.OrderData", code: errorcode, userInfo: [NSLocalizedDescriptionKey: json[WSKeys.parameters.messageError].stringValue ]))
                   }
                  
               case .failure(let error):
                   failure(error as NSError)
               }
           }
       }
}


