//
//  FGMFacturasModel.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 5/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMFacturasModel: NSObject {
    var Nombre: String?
    var Fichero: String?
    
    init(pNombre: String, pFichero: String) {
        self.Nombre = pNombre
        self.Fichero = pFichero
        super.init()
        
    }

}
