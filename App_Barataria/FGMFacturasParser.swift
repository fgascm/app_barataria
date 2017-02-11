//
//  FGMFacturasParser.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 5/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import SwiftyJSON

class FGMFacturasParser: NSObject {

    open func getFacturasModel(_ dataFromNetwork:Data)->[FGMFacturasModel]{
        
        var arrayFacturasModel = [FGMFacturasModel]()
        
        //1. lectura JSON
        
        let readableJSON = JSON(data: dataFromNetwork, options: .mutableContainers, error: nil)
        
        for index in 0...readableJSON.count-1{
            
            let facturasModel = FGMFacturasModel(pNombre: dimeString(readableJSON[index], nombre: "NOMBRE"), pFichero: dimeString(readableJSON[index], nombre: "FICHERO"))
            
            arrayFacturasModel.append(facturasModel)
            
        }
        
        return arrayFacturasModel
    }
    

    
}
