//
//  FGMActividadesTableViewCell.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 28/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMActividadesTableViewCell: UITableViewCell {
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myNombreLBL: UILabel!
    @IBOutlet weak var myFechaLBL: UILabel!
    @IBOutlet weak var myTipoLBL: UILabel!
    @IBOutlet weak var myLugarLBL: UILabel!
    @IBOutlet weak var myPrecioLBL: UILabel!
    @IBOutlet weak var myDescripcionLBL: UILabel!
    @IBOutlet weak var myImagenActividad: UIImageView!
    @IBOutlet weak var myImagenFinalizado: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
