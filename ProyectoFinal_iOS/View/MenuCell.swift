//
//  MenuCell.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 03/12/23.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuOptionImage: UIImageView!
    @IBOutlet weak var menuOptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
