//
//  FGMUtilidades.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 16/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import SwiftyJSON


let CONSTANTES = Constantes()


//MARK: - Alertas

public func showAlertVC(_ titleData:String,messageData:String) -> UIAlertController{
    
    let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
}



//MARK: - Envío eMails
func configuredMailComposeViewController(_ myArrayString: [String], mySTringSubject: String, myStringMessage: String, myBoolHTML: Bool) -> MFMailComposeViewController{
    let mailCompose = MFMailComposeViewController()
    //mailCompose.mailComposeDelegate = self
    mailCompose.setToRecipients(myArrayString)
    mailCompose.setSubject(mySTringSubject)
    mailCompose.setMessageBody(myStringMessage, isHTML: myBoolHTML)
    
    
    return mailCompose
    
    
}


//MARK: - NULL / STRING ""
public func dimeString(_ j: JSON, nombre: String) -> String{
    if let stringResult = j[nombre].string{
        return stringResult
    }
    else{
        return ""
    }
    
}

//MARK: - NULL / INT 0
public func dimeInt(_ j: JSON, nombre: String) -> Int{
    if let intResult = j[nombre].int{
        return intResult
    }
    else{
        return 0
    }
    
}


//MARK: - NULL / DOUBLE 0.0
public func dimeDouble(_ j: JSON, nombre: String) -> Double{
    if let doubleResult = j[nombre].double{
        return doubleResult
    }
    else{
        return 0.0
    }
    
}



//MARK: - NULL / FLOAT 0
public func dimeFloat(_ j: JSON, nombre: String) -> Float{
    if let floatResult = j[nombre].float{
        return floatResult
    }
    else{
        return 0
    }
    
}

//MARK: - NULL/BOOLEAN false
public func dimeBool(_ j: JSON, nombre: String) -> Bool{
    if let boolResult = j[nombre].bool{
        return boolResult
    }
    else{
        return false
    }
    
}





