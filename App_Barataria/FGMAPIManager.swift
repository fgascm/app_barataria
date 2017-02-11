//
//  FGMAPIManager.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 31/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMAPIManager: NSObject {

    //MAR: - VARIABLES LOCALES
    fileprivate let CONSTANTES = Constantes()
    fileprivate let convenios = FGMConveniosParse()
    fileprivate let actividades = FGMActividadesParser()
    fileprivate let ofertas = FGMOfertasParser()
    fileprivate let facturas = FGMFacturasParser()
    fileprivate let enlaces = FGMEnlacesParser()
    
    
    //MARK: - SINGLETON
    class var sharedInstance : FGMAPIManager{
        struct SingletonApp{
            static let instancia = FGMAPIManager()
        }
        return SingletonApp.instancia
    }
    
    
    //MARK: - GET Convenios
    func getConvenios() -> [FGMConveniosModel]{
        let url = URL(string: CONSTANTES.BASE_URL_CONVENIOS)
        let jsonData = try? Data(contentsOf: url!)
        let arrayConvenios = convenios.getConveniosModel(jsonData!)
        return arrayConvenios
    }
    
   //MARK: - GET Actividades
     func getActividades() -> [FGMActividadesModel]{
        let url = URL(string: CONSTANTES.BASE_URL_ACTIVIDADES)
        let jsonData = try? Data(contentsOf: url!)
        let arrayActividades = actividades.getActividadesModel(jsonData!)
        return arrayActividades
     }
    
    
    
    //MARK: - GET Ofertas
    func getOfertas() -> [FGMOfertasModel]{
        let url = URL(string: CONSTANTES.BASE_URL_OFERTAS)
        let jsonData = try? Data(contentsOf: url!)
        let arrayOfertas = ofertas.getOfertasModel(jsonData!)
        return arrayOfertas
    }

    //MARK: - GET Facturas
    func getFacturas() -> [FGMFacturasModel]{
        let url = URL(string: CONSTANTES.BASE_URL_FACTURAS)
        let jsonData = try? Data(contentsOf: url!)
        let arrayFacturas = facturas.getFacturasModel(jsonData!)
        return arrayFacturas
    }
    
    //MARK: - GET Enlaces
    func getEnlaces() -> [FGMEnlacesModel]{
        let url = URL(string: CONSTANTES.BASE_URL_ENLACES)
        let jsonData = try? Data(contentsOf: url!)
        let arrayEnlaces = enlaces.getEnlacesModel(jsonData!)
        return arrayEnlaces
    }
    
}
