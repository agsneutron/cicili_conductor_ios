//
//  VerifyStatus.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 15/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import Foundation

class VerifyStatus  {
  
    func getClientStatus(setToken: String) -> String {
        
        var status = ""
        
        RequestManager.fetchClientStatus(oauthToken: setToken , success: { response in
           
            
            if let statusUpdated = response.status, !statusUpdated.isEmpty{
                print("En success status updated \(statusUpdated)")
                status = statusUpdated
            }
        })
        { error in
            status = ""
        }
        return status
    }
    
    
}
