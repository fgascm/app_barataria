//
//  FGMConveniosParse.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 30/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import SwiftyJSON

class FGMConveniosParse: NSObject {
    open func getConveniosModel(_ dataFromNetwork:Data)->[FGMConveniosModel]{
        
        var arrayConveniosModel = [FGMConveniosModel]()
        
        //1. lectura JSON
        
        let readableJSON = JSON(data: dataFromNetwork, options: .mutableContainers, error: nil)
        
        for index in 0...readableJSON.count-1{
            let concesionarioModel = FGMConveniosModel(pPublicacion: dimeString(readableJSON[index], nombre: "PUBLICACION"), pTipo: dimeString(readableJSON[index], nombre: "TIPO"), pNombre: dimeString(readableJSON[index], nombre: "NOMBRE"), pImagen: dimeString(readableJSON[index], nombre: "IMAGEN"), pFichero: dimeString(readableJSON[index], nombre: "FICHERO"), pContacto: dimeString(readableJSON[index], nombre: "CONTACTO"), pWeb: dimeString(readableJSON[index], nombre: "WEB"), pInicio: dimeString(readableJSON[index], nombre: "INICIO"), pFin: dimeString(readableJSON[index], nombre: "FIN"), pMostrar: dimeString(readableJSON[index], nombre: "MOSTRAR"), pDescripcion: dimeString(readableJSON[index], nombre: "DESCRIPCION"), pId: dimeInt(readableJSON[index], nombre: "ID"))
            
            arrayConveniosModel.append(concesionarioModel)
            
        }
        
        return arrayConveniosModel
    }

    
}
