//
//  FGMConveniosDetalle.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 31/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMConveniosDetalle: UIViewController {
    
    //MARK: - VARIABLES
    var modeloConveniosData : FGMConveniosModel?

    
    //MARK:- IBOutlet
    
    @IBOutlet weak var myEmpresaLBL: UILabel!
    @IBOutlet weak var myContactoLBL: UILabel!
    @IBOutlet weak var myWebLBL: UILabel!
    @IBOutlet weak var myDescripcionLBL: UILabel!
    @IBOutlet weak var myImagenLogo: UIImageView!
    @IBOutlet weak var btnDetalles: UIButton!

    
    
    
    //Utilidades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Identifico el segue por el que estamos pasando
        if segue.identifier == "verPDF" {
            //creamos la instancia del objeto que recibira los datos de una ventana
            
            let ventanaPDF = segue.destination as! FGMConveniosDocumentosViewController
            ventanaPDF.myUrl = (modeloConveniosData?.Fichero)!
            
            
            
        }
    }

    
    
    

    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        myEmpresaLBL.text = modeloConveniosData?.Nombre
        myContactoLBL.text = String(modeloConveniosData!.Contacto!)
        myWebLBL.text = modeloConveniosData?.Web
        myDescripcionLBL.text = modeloConveniosData?.Descripcion

        let url = URL(string: (modeloConveniosData?.Imagen!)!)
        myImagenLogo.kf.setImage(with: url)
        
        btnDetalles.layer.cornerRadius = btnDetalles.frame.width / 8
               myImagenLogo.clipsToBounds = true
        
        

        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
