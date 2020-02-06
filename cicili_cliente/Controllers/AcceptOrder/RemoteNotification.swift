//
//  RemoteNotification.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 01/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//
import UIKit

class RemoteNotification{

    //MARK: Properties
    var id: Int=0
    var body: String
    var title: String

    
     
     //MARK: Initialization
     
     init?(id: Int,body: String,title: String) {
         
         // The name must not be empty
         guard !body.isEmpty else {
             return nil
         }
        guard !title.isEmpty else {
            return nil
        }

         
         // Initialize stored properties.
        self.body = body
        self.title = title
        self.id = id
     }

}
