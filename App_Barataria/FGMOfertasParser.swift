//
//  FGMOfertasParser.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 4/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import SwiftyJSON

class FGMOfertasParser: NSObject {

    open func getOfertasModel(_ dataFromNetwork:Data)->[FGMOfertasModel]{
        
        var arrayOfertasModel = [FGMOfertasModel]()
        
        //1. lectura JSON
        
        let readableJSON = JSON(data: dataFromNetwork, options: .mutableContainers, error: nil)
        
        for index in 0...readableJSON.count-1{
            
            let ofertasModel = FGMOfertasModel(pNombre: dimeString(readableJSON[index], nombre: "NOMBRE"), pImagen: dimeString(readableJSON[index], nombre: "IMAGEN"))
            arrayOfertasModel.append(ofertasModel)
            
        }
        
        return arrayOfertasModel
    }
    
}


