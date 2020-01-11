//
//  Address.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 11/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit


class Address {
    
    //MARK: Properties
    
    var name: String
    
    //MARK: Initialization
    
    init?(name: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        self.name = name
        
    }
}
