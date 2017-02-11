//
//  FGMEnlacesParser.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 6/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import SwiftyJSON

class FGMEnlacesParser: NSObject {
    open func getEnlacesModel(_ dataFromNetwork:Data)->[FGMEnlacesModel]{
        
        var arrayEnlacesModel = [FGMEnlacesModel]()
        
        //1. lectura JSON
        
        let readableJSON = JSON(data: dataFromNetwork, options: .mutableContainers, error: nil)
        
        for index in 0...readableJSON.count-1{
            
            
            let enlaceModel = FGMEnlacesModel(pNombre: dimeString(readableJSON[index], nombre: "NOMBRE"), pWeb: dimeString(readableJSON[index], nombre: "WEB"))
            arrayEnlacesModel.append(enlaceModel)
            
        }
        
        return arrayEnlacesModel
    }

}
