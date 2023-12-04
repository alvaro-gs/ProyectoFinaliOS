//
//  PedidoCell.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 04/10/23.
//

import UIKit

protocol PedidoCellDelegate {
    
    func button(_ button: UIButton, touchedIn cell: PedidoCell)
}

class PedidoCell: UITableViewCell {
    
    var delegate: PedidoCellDelegate?
    @IBOutlet weak var btEditPedido: UIButton!
    @IBOutlet weak var btDeletePedido: UIButton!
    @IBOutlet weak var estatusPedido: UILabel!
    @IBOutlet weak var imagePedido: UIImageView!
    
    
    
    @IBAction func buttonTouch(_ button: UIButton) {
        if delegate != nil {
            delegate!.button(button, touchedIn: self)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
