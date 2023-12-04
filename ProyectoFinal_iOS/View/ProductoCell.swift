//
//  ProductoCell.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 12/10/23.
//

import UIKit

class ProductoCell: UITableViewCell {

    @IBOutlet weak var productoName: UILabel!
    @IBOutlet weak var productoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
