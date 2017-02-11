//
//  FGMConveniosTableViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 26/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu

class FGMConveniosTableViewController: UITableViewController {
    
    //MARK: - VARIABLES
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var refresh = UIRefreshControl()
    let CONSTANTES = Constantes()
    var arrayConvenios = [FGMConveniosModel]()

    
    
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
        
        refresh.backgroundColor = UIColor(red: 1.0, green: 0.50, blue: 0, alpha: 1.0)
        refresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh.addTarget(self, action: #selector(FGMConveniosTableViewController.refreshMethod), for: .valueChanged)
        tableView.addSubview(refresh)
        getSingleton()
        
        
    }
    
    
    func refreshMethod(){
        getSingleton()
        tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    
    func getSingleton(){
        arrayConvenios = FGMAPIManager.sharedInstance.getConvenios()
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
        return arrayConvenios.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FGMConveniosTableViewCell

        let model = arrayConvenios[indexPath.row]
        
        cell.myEmpresaLBL.text = model.Nombre
        cell.myContactoLBL.text = ("Tel: " + model.Contacto!) as String
        cell.myWebLBL.text = ("Web: " + model.Web!) as String
        let url = URL(string: model.Imagen!)
        cell.myImagenConvenio.kf.setImage(with: url)
        
        
        //cell.myImageConcesionario.kf_setImageWithURL(URL(string: getImagePath(model.Imagen!)))


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleConveniosVC = self.storyboard?.instantiateViewController(withIdentifier: "detalleConvenioData") as! FGMConveniosDetalle
            detalleConveniosVC.modeloConveniosData = arrayConvenios[indexPath.row]
        navigationController?.pushViewController(detalleConveniosVC, animated: true)

    }
    


}
extension FGMConveniosTableViewController: FlowingMenuDelegate {
    
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "convenios", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisConvenios", sender: self)
    }
    
    
    
    
}

