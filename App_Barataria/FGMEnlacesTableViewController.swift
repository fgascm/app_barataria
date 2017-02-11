//
//  FGMEnlacesTableViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 26/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu

class FGMEnlacesTableViewController: UITableViewController {

    //MARK: - VARIABLES
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var refresh = UIRefreshControl()
    let CONSTANTES = Constantes()
    var arrayEnlaces = [FGMEnlacesModel]()
    
    
    
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
        arrayEnlaces = FGMAPIManager.sharedInstance.getEnlaces()
    }
    
    
    
    
    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        flowingMenuTransitionManager.delegate = self
        
        refresh.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(FGMEnlacesTableViewController.refreshMethod), for: .valueChanged)
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
        return arrayEnlaces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FGMEnlacesTableViewCell
        
        let model = arrayEnlaces[indexPath.row]
        
        cell.myNombreLBL.text = model.Nombre
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleEnlacesVC = self.storyboard?.instantiateViewController(withIdentifier: "verEnlace") as! FGMEnlacesDetalleViewController
        let model = arrayEnlaces[indexPath.row]
        detalleEnlacesVC.myUrl = model.Web
        navigationController?.pushViewController(detalleEnlacesVC, animated: true)
    }


}

extension FGMEnlacesTableViewController: FlowingMenuDelegate {
    
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "enlaces", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisEnlaces", sender: self)
    }
    
    
    
    
}

