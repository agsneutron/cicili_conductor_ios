//
//  AvailableDrivers.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 16/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit

class AvailableDrivers{

    //MARK: Properties
     var id: Int=0
     var name: String
    
     
     //MARK: Initialization
     
     init?(id: Int,name: String) {
         
         // The name must not be empty
         guard !name.isEmpty else {
             return nil
         }

         
         // Initialize stored properties.
         self.name = name
         self.id = id
     }

}
