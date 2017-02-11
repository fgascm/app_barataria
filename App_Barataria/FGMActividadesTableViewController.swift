//
//  FGMActividadesTableViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 25/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu
import Kingfisher

class FGMActividadesTableViewController: UITableViewController {

    
    //MARK: - VARIABLES
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var refresh = UIRefreshControl()
    let CONSTANTES = Constantes()
    var arrayActividades = [FGMActividadesModel]()
    var fecha : String?
    var fecha2: String?
    
    //MARK: - Utilidades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc                   = segue.destination
        vc.transitioningDelegate = flowingMenuTransitionManager
    }
    
    func refreshMethod(){
        getSingleton()
        tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    
    func getSingleton(){
        arrayActividades = FGMAPIManager.sharedInstance.getActividades()
    }
    

    
    
    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()

        
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        flowingMenuTransitionManager.delegate = self
        refresh.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(FGMActividadesTableViewController.refreshMethod), for: .valueChanged)
        tableView.addSubview(refresh)
        getSingleton()
        
        
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayActividades.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FGMActividadesTableViewCell

        
        let model = arrayActividades[indexPath.row]

        
        fecha = model.Inicio

        
        var startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 8)
        var endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 9)
        
        let dia = fecha?[startIndex!...endIndex!]
        
        startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 5)
        endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 6)
        let mes = fecha?[startIndex!...endIndex!]
        
        startIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 0)
        endIndex = fecha?.index((fecha?.startIndex)!, offsetBy: 3)
        let anio = fecha?[startIndex!...endIndex!]
        
        
        let fec_mostrar = dia! + "-" + mes! + "-" + anio!


        let url = URL(string: model.Imagen!)
        cell.myImagenActividad.kf.setImage(with: url)
        
        if model.Mostrar! {
            cell.myImagenFinalizado.isHidden = true
        }
        else{
            cell.myImagenFinalizado.isHidden = false
        }

        cell.myTipoLBL.text = model.Tipo
        cell.myDescripcionLBL.text = model.Descripcion
        cell.myNombreLBL.text = model.Nombre
        cell.myFechaLBL.text = model.Inicio
        cell.myLugarLBL.text = model.Lugar
        cell.myPrecioLBL.text = String(model.Precio!) + " €"
        cell.myFechaLBL.text = fec_mostrar
        


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleActividadesVC = self.storyboard?.instantiateViewController(withIdentifier: "detalleActividad") as! FGMActividdesDetalleVC
        detalleActividadesVC.modeloActividadesData = arrayActividades[indexPath.row]
        navigationController?.pushViewController(detalleActividadesVC, animated: true)
        
    }
   

}

    // MARK: - FlowingMenu Delegate Methods
extension FGMActividadesTableViewController: FlowingMenuDelegate {

    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "actividades", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisActividades", sender: self)
    }
    
    
    
    
}
