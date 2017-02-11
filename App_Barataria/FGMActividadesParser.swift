//
//  FGMActividadesParser.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 31/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import SwiftyJSON

class FGMActividadesParser: NSObject {
    open func getActividadesModel(_ dataFromNetwork:Data)->[FGMActividadesModel]{
        
        var arrayActividadesModel = [FGMActividadesModel]()
        
        //1. lectura JSON
        
        let readableJSON = JSON(data: dataFromNetwork, options: .mutableContainers, error: nil)
        
        for index in 0...readableJSON.count-1{
           
            let actividadModel = FGMActividadesModel(pPublicacion: dimeString(readableJSON[index], nombre: "PUBLICACION"), pTipo: dimeString(readableJSON[index], nombre: "TIPO"), pNombre: dimeString(readableJSON[index], nombre: "NOMBRE"), pContacto: dimeInt(readableJSON[index], nombre: "CONTACTO"), pWeb: dimeString(readableJSON[index], nombre: "WEB"), pInicio: dimeString(readableJSON[index], nombre: "INICIO"), pFin: dimeString(readableJSON[index], nombre: "FIN"), pMostrar: dimeBool(readableJSON[index], nombre: "MOSTRAR"), pDescripcion: dimeString(readableJSON[index], nombre: "DESCRIPCION"), pId: dimeInt(readableJSON[index], nombre: "ID"), pLugar: dimeString(readableJSON[index], nombre: "LUGAR"), pPlazas: dimeString(readableJSON[index], nombre: "PLAZAS"), pPrecio: dimeInt(readableJSON[index], nombre: "PRECIO"), pPrcioNo: dimeInt(readableJSON[index], nombre: "PRECIONO"), pFecLimite: dimeString(readableJSON[index], nombre: "FECLIMITE"), pLatitud: dimeDouble(readableJSON[index], nombre: "LATITUD"), pLongitud: dimeDouble(readableJSON[index], nombre: "LONGITUD"), pDoc: dimeString(readableJSON[index], nombre: "DOC"), pImagen: dimeString(readableJSON[index], nombre: "IMAGEN"))
            
            arrayActividadesModel.append(actividadModel)
            
        }
        
        return arrayActividadesModel
    }

}
