//
//  FGMLoginViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 16/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import Parse

class FGMLoginViewController: UIViewController {


    //MARK: - IBOutlets

    @IBOutlet weak var miUsuario: UITextField!
    @IBOutlet weak var miContraseña: UITextField!
    @IBOutlet weak var miActivity: UIActivityIndicatorView!
    
    
    
    //MARK: - IBActions
    
    @IBAction func btnRegistrar(_ sender: Any) {
        if miUsuario.text == "" || miContraseña.text == "" {
            present(showAlertVC("Estimado usuario", messageData: "Por favor, relleno los campos de acceso"), animated: true, completion: nil)
        }
        else{
            
            self.miActivity.isHidden = false
            self.miActivity.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            PFUser.logInWithUsername(inBackground: miUsuario.text!, password: miContraseña.text!) { (userFromParse, errorLogIn) in
                
                self.miActivity.isHidden = true
                self.miActivity.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if userFromParse != nil{
                    print("El usuario ha logrado acceder")
                    self.performSegue(withIdentifier: "myPresentacionTabBarViewController", sender: self)
                    self.miUsuario.text = ""
                    self.miContraseña.text = ""
                }
                else{
                    if let errorString = (errorLogIn! as NSError).userInfo["error"] as? NSString{
                        self.present(showAlertVC("ATENCION", messageData: errorString as String), animated: true, completion: nil)
                        
                    }
                    else{
                        self.present(showAlertVC("ATENCION", messageData: "Error en el registro"), animated: true, completion: nil)
                    }
                }
            }

    }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        miActivity.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current()?.username != nil{
            performSegue(withIdentifier: "myPresentacionTabBarViewController", sender: self)
        }
        else{
            print("El usuario no existe todavia")
        }
    }

    
        

}
