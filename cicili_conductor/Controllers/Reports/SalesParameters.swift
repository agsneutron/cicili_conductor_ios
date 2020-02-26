//
//  SalesParameters.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 24/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit


class SalesParameters {
    
    //MARK: Properties
    var type: String?
    var initialDate: String?
    var endDate: String?
    var conductor: String?
   
    
    //MARK: Initialization
    
    init?(type: String,initialDate: String, endDate: String, conductor: String) {
        
        
        // Initialize stored properties.
        self.type = type
        self.initialDate = initialDate
        self.endDate = endDate
        self.conductor = conductor
    }
}
