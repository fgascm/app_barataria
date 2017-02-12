//
//  FGMFacturasTableViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 26/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu
import Parse

class FGMFacturasTableViewController: UITableViewController {

    //MARK: - VARIABLES
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var refresh = UIRefreshControl()
    let CONSTANTES = Constantes()
    var arrayFacturas = [FGMFacturasModel]()
    var stringQr : String?

    
    
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
        arrayFacturas = FGMAPIManager.sharedInstance.getFacturas()
    }

    func actualizarDatos(){
        
        //1 consulta
        
        let queryUser = PFUser.query()!
        queryUser.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser.findObjectsInBackground { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno{
                    for objectDataUnoDes in objectUnoDes{
                        self.stringQr = objectDataUnoDes["numsocio"] as? String
                    }
                }
            }
        }
        
    }

    

    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualizarDatos()
        
        
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        flowingMenuTransitionManager.delegate = self
        
        refresh.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(FGMFacturasTableViewController.refreshMethod), for: .valueChanged)
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
        return arrayFacturas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FGMFacturasTableViewCell

        let model = arrayFacturas[indexPath.row]
        
        cell.myFacturaLBL.text = model.Nombre
        
        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleFacturasVC = self.storyboard?.instantiateViewController(withIdentifier: "verFactura") as! FGMFacturasDetalleViewController
        let model = arrayFacturas[indexPath.row]
        let factura = ((model.Fichero)! + "0" + stringQr! + ".pdf") as String
        detalleFacturasVC.myUrl = factura
        navigationController?.pushViewController(detalleFacturasVC, animated: true)
    }

   
}


extension FGMFacturasTableViewController: FlowingMenuDelegate {
    
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "facturas", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisFacturas", sender: self)
    }
    
    
    
    
}
