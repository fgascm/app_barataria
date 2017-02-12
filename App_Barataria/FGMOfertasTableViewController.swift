//
//  FGMOfertasTableViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 26/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu

class FGMOfertasTableViewController: UITableViewController {

    //MARK: - VARIABLES
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var refresh = UIRefreshControl()
    let CONSTANTES = Constantes()
    var arrayOfertas = [FGMOfertasModel]()
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc                   = segue.destination
        vc.transitioningDelegate = flowingMenuTransitionManager
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the pan screen edge gesture to the current view
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        // Add the delegate to respond to interactive transition events
        flowingMenuTransitionManager.delegate = self
        
        refresh.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(FGMOfertasTableViewController.refreshMethod), for: .valueChanged)
        tableView.addSubview(refresh)
        getSingleton()
        
        
    }
    
    
    func refreshMethod(){
        getSingleton()
        tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    
    func getSingleton(){
        arrayOfertas = FGMAPIManager.sharedInstance.getOfertas()
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
        return arrayOfertas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FGMOfertasTableViewCell
        
        let model = arrayOfertas[indexPath.row]
        
        cell.myNombreLBL.text = model.Nombre
        
        let url = URL(string: model.Imagen!)
        cell.myImagenOferta.kf.setImage(with: url)
        
        
        
        //cell.myImageConcesionario.kf_setImageWithURL(URL(string: getImagePath(model.Imagen!)))
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleOfertasVC = self.storyboard?.instantiateViewController(withIdentifier: "verOfertas") as! FGMOfertasDetalleViewController
        let model = arrayOfertas[indexPath.row]
        detalleOfertasVC.myUrl = model.Imagen
        navigationController?.pushViewController(detalleOfertasVC, animated: true)
    }
}
extension FGMOfertasTableViewController: FlowingMenuDelegate {
    
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "ofertas", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisOfertas", sender: self)
    }
    
    
    
    
}

