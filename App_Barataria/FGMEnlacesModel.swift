//
//  FGMEnlacesModel.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 6/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMEnlacesModel: NSObject {
    
    var Nombre: String?
    var Web: String?
    
    init(pNombre: String, pWeb: String) {
        self.Nombre = pNombre
        self.Web = pWeb
        super.init()
        
    }

    

}
