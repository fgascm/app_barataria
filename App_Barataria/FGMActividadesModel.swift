//
//  FGMActividadesModel.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 31/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMActividadesModel: NSObject {
    
    var Publicacion: String?
    var Tipo: String?
    var Nombre: String?
    var Contacto: Int?
    var Web: String?
    var Inicio: String?
    var Fin: String?
    var Mostrar: Bool?
    var Descripcion: String?
    var Id: Int?
    var Lugar : String?
    var Plazas: String?
    var Precio: Int?
    var PrcioNo: Int?
    var FecLimite: String?
    var Latitud: Double?
    var Longitud: Double?
    var Doc: String?
    var Imagen: String?
    
    
    
    init(pPublicacion: String,pTipo: String,pNombre: String,pContacto: Int,pWeb: String,pInicio: String,pFin: String,pMostrar: Bool,pDescripcion: String,pId: Int, pLugar : String,
                    pPlazas: String,
                    pPrecio: Int,
                    pPrcioNo: Int,
                    pFecLimite: String,
                    pLatitud: Double,
                    pLongitud: Double, pDoc: String,
                    pImagen: String) {
        self.Publicacion = pPublicacion
        self.Tipo = pTipo
        self.Nombre = pNombre
        self.Contacto = pContacto
        self.Web = pWeb
        self.Inicio = pInicio
        self.Fin = pFin
        self.Mostrar = pMostrar
        self.Descripcion = pDescripcion
        self.Id = pId
        self.Lugar = pLugar
        self.Plazas = pPlazas
        self.Precio = pPrecio
        self.PrcioNo = pPrcioNo
        self.FecLimite = pFecLimite
        self.Latitud = pLatitud
        self.Longitud = pLongitud
        self.Doc = pDoc
        self.Imagen = pImagen
        super.init()
    }

}
