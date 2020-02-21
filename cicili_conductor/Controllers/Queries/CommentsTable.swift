//
//  CommentsTable.swift
//  cicili_conductor
//
//  Created by ARIANA SANCHEZ on 31/12/18.
//  Copyright © 2018 CICILI. All rights reserved.
//

import UIKit


class CommentsTable {
    
    //MARK: Properties
    var idPedido: Int=0
    var fecha: String?
    var calificacion: Int=0
    var comentario: String?
    var nombreCliente: String?
   
    
    //MARK: Initialization
    
    init?(idPedido: Int,fecha: String,calificacion: Int,comentario: String,nombreCliente: String) {
        
        // The name must not be empty
        /*guard !fecha.isEmpty else {
            return nil
        }
        guard !comentario.isEmpty else {
            return nil
        }
        guard !nombreCliente.isEmpty else {
            return nil
        }*/

        
        // Initialize stored properties.
        self.idPedido = idPedido
        self.fecha = fecha
        self.calificacion = calificacion
        self.comentario = comentario
        self.nombreCliente = nombreCliente
    }
}
