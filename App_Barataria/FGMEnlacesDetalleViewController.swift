//
//  FGMEnlacesDetalleViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 6/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMEnlacesDetalleViewController: UIViewController {
    
    //MARK: - VARIABLES
    var myUrl: String?
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var myWebView: UIWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: myUrl!)
        let requestObj = NSURLRequest(url: url! as URL);
        myWebView.loadRequest(requestObj as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
