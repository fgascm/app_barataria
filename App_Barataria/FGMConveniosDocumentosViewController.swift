//
//  FGMConveniosDocumentosViewController.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 6/2/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMConveniosDocumentosViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
