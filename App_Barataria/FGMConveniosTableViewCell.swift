//
//  FGMConveniosTableViewCell.swift
//  App_Barataria
//
//  Created by Francisco Javier Gascón Mora on 28/1/17.
//  Copyright © 2017 Francisco Javier Gascón Mora. All rights reserved.
//

import UIKit

class FGMConveniosTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var myEmpresaLBL: UILabel!
    @IBOutlet weak var myContactoLBL: UILabel!
    @IBOutlet weak var myWebLBL: UILabel!
    @IBOutlet weak var myImagenConvenio: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
