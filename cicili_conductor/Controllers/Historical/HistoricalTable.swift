//
//  HistoricalTable.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 20/02/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit


class HistoricalTable {
    
    //MARK: Properties
    var horaSolicitada: String?
    var fechaSolicitada: String?
    var monto: Double=0.0
    var formaPago: String?
    var direccion: String?
    var nombreStatus: String?
   
    
    //MARK: Initialization
    
    init?(horaSolicitada: String,fechaSolicitada: String,monto: Double,formaPago: String,direccion: String, nombreStatus: String) {
        
        
        // Initialize stored properties.
        self.horaSolicitada = horaSolicitada
        self.fechaSolicitada = fechaSolicitada
        self.monto = monto
        self.formaPago = formaPago
        self.direccion = direccion
        self.nombreStatus = nombreStatus
    }
}
