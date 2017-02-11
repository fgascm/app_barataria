//
//  FGMTarjetaViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 7/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit
import Parse
import FlowingMenu

class FGMTarjetaViewController: UIViewController {
    
    
    //MARK: - Variables
    var nombreSocio : String?
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    var menu: UIViewController?
    var imageGroupTag = 1
    var stringQr : String?
    

    
    //MARK: - IBOutlet
    
    @IBOutlet weak var miNombreSocioLBL: UILabel!
    @IBOutlet weak var myNumeroSocioLBL: UILabel!
    
    
    

    //MARK: - IBActions
    
    @IBAction func btnGeneraQR(_ sender: Any) {
        
        let background = UIView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height))
        background.backgroundColor = UIColor.black
        background.alpha = 0.8
        background.tag = imageGroupTag
        self.view.addSubview(background)
     //   let aSelector : Selector = #selector(FGMTarjetaViewController.removeSubview1)
      //  let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        //background.addGestureRecognizer(tapGesture)

        
        if stringQr != nil{
            let anchoPantallaSubview = self.view.frame.size.width / 2
            let altoPantallaSubview = self.view.frame.size.height / 2
            let imageViewDataQR = UIImageView(frame: CGRect(x: anchoPantallaSubview/2, y: altoPantallaSubview/2, width: self.view.frame.width/1.8, height: self.view.frame.height/3))
            //let imageViewDataQR = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width/2, self.view.frame.height/2))
            imageViewDataQR.contentMode = .scaleAspectFit
            imageViewDataQR.tag = 100
            
            let dataQR = stringQr?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(dataQR, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            var qrCodeImage = CIImage()
            qrCodeImage = (filter?.outputImage)!
            imageViewDataQR.image = UIImage(ciImage: qrCodeImage)
            self.view.addSubview(imageViewDataQR)
            let aSelector : Selector = #selector(FGMTarjetaViewController.removeSubview)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            background.addGestureRecognizer(tapGesture)



            
        }
        else{
            self.present(showAlertVC("Estimado Usuario", messageData: "Hemos tenido un problema al generar el QR"), animated: true, completion: nil)
        }
        
    

    }
    

func removeSubview(){
 
    if let viewWithTag = self.view.viewWithTag(100) {
        viewWithTag.removeFromSuperview()
           print("Quitando subview")
        self.view.viewWithTag(imageGroupTag)?.removeFromSuperview()

    }else{
        print("No!")
    }
}
    

    
    //MARK: - Vida VC
    override func viewDidLoad() {
        super.viewDidLoad()

         actualizarDatos()
        
        
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        flowingMenuTransitionManager.delegate = self


        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Utilidades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc                   = segue.destination
        vc.transitioningDelegate = flowingMenuTransitionManager
    }

    
    
    func actualizarDatos(){
        
        //1 consulta
        
        let queryUser = PFUser.query()!
        queryUser.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser.findObjectsInBackground { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno{
                    for objectDataUnoDes in objectUnoDes{
                        self.nombreSocio = (objectDataUnoDes["nombreUsuario"] as? String)! + " " + (objectDataUnoDes["apeliidoUsuario"] as? String)!
                        self.miNombreSocioLBL.text = self.nombreSocio
                        self.myNumeroSocioLBL.text = objectDataUnoDes["numsocio"] as? String
                        self.stringQr = objectDataUnoDes["numsocio"] as? String
                    }
                }
            }
        }
        
    }


        
}

extension FGMTarjetaViewController: FlowingMenuDelegate {
    // MARK: - FlowingMenu Delegate Methods
    
    func flowingMenuNeedsPresentMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        performSegue(withIdentifier: "menuTarjeta", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(_ flowingMenu: FlowingMenuTransitionManager) {
        menu?.performSegue(withIdentifier: "dissmisTarjeta", sender: self)
    }
    
    
    
    
}
