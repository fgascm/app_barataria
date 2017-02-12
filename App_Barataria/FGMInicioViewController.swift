//
//  FGMInicioViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 7/12/16.
//  Copyright © 2016 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import FlowingMenu
import MessageUI
import Foundation

class FGMInicioViewController: UIViewController {
    
    
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
       var menu: UIViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc                   = segue.destination
        vc.transitioningDelegate = flowingMenuTransitionManager
    }
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myWebView: UIWebView!
    
    
    
    //MARK: - IBActions
    
    @IBAction func sendGeneral(_ sender: Any) {
        enviarCorrero(destino: "barataria@asociacionbarataria.es")
    }
    
    @IBAction func sendVodafone(_ sender: Any) {
        enviarCorrero(destino: "vodafone@asociacionbarataria.es")
    }
    
    @IBAction func sendConvenios(_ sender: Any) {
        enviarCorrero(destino: "convenios@asociacionbarataria.es")
    }
    
    
    @IBAction func sendActividades(_ sender: Any) {
        enviarCorrero(destino: "actividades@asociacionbarataria.es")
    }
    
    @IBAction func sendWeb(_ sender: Any) {
        enviarCorrero(destino: "web@asociacionbarataria.es")
    }
    
    @IBAction func sendLOPD(_ sender: Any) {
        enviarCorrero(destino: "lopd@asociacionbarataria.es")
    }
    
    
    
    //MARK: - UTILIDADES
    func enviarCorrero(destino: String){
        let mailcomposeViewController = configuredMailComposeViewController([destino], mySTringSubject: "Mensaje desde app iOS", myStringMessage: "Mensaje generado desde la apliacion móvil de Barataria", myBoolHTML: false)
        mailcomposeViewController.mailComposeDelegate = self
        if MFMailComposeViewController.canSendMail(){
            present(mailcomposeViewController, animated: true, completion: nil)
        }
        else{
            self.present(showAlertVC("ATENCIÓN", messageData: "El mail no se ha logrado enviar correctamente"), animated: true, completion: nil)
        }

    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: "http://www.asociacionbarataria.es/ios/app_ios.aspx")
        let requestObj = NSURLRequest(url: url! as URL);
        myWebView.loadRequest(requestObj as URLRequest)
        

        flowingMenuTransitionManager.setInteractivePresentationView(view)
        
        
        flowingMenuTransitionManager.delegate = self
    }
    


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }


}
extension FGMInicioViewController: FlowingMenuDelegate {
    // MARK: - FlowingMenu Delegate Methods
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "prueba", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmis", sender: self)
    }
    
    


}


//MARK: - DELEGADO DE MFMainComposeViewController
extension FGMInicioViewController : MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
