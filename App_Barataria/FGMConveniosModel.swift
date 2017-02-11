//
//  FGMConveniosModel.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 30/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMConveniosModel: NSObject {
    
    
    var Publicacion: String?
    var Tipo: String?
    var Nombre: String?
    var Imagen: String?
    var Fichero: String?
    var Contacto: String?
    var Web: String?
    var Inicio: String?
    var Fin: String?
    var Mostrar: String?
    var Descripcion: String?
    var Id: Int?
    
    
    init(pPublicacion: String,pTipo: String,pNombre: String,pImagen: String,pFichero: String,pContacto: String,pWeb: String,pInicio: String,pFin: String,pMostrar: String,pDescripcion: String,pId: Int) {
        self.Publicacion = pPublicacion
        self.Tipo = pTipo
        self.Nombre = pNombre
        self.Imagen = pImagen
        self.Fichero = pFichero
        self.Contacto = pContacto
        self.Web = pWeb
        self.Inicio = pInicio
        self.Fin = pFin
        self.Mostrar = pMostrar
        self.Descripcion = pDescripcion
        self.Id = pId
        super.init()
    }
    

}
