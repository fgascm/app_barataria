//
//  FGMOfertasModel.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 4/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMOfertasModel: NSObject {
    
    var Nombre: String?
    var Imagen: String?
    
    init(pNombre: String, pImagen: String) {
        self.Nombre = pNombre
        self.Imagen = pImagen
        super.init()
        
    }
    

}
