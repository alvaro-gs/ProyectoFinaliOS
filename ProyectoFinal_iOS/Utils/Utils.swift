//
//  Utils.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 23/12/23.
//

import Foundation
import UIKit

class Utils{
    static func createButton (title:String, color:UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = color
        button.setTitle(title, for:.normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createProgressBar(color: UIColor) -> UIActivityIndicatorView  {
        let progress = UIActivityIndicatorView()
        progress.style = .large
        progress.color = color
        progress.translatesAutoresizingMaskIntoConstraints = false
            
        return progress
    }
    
    static func createErrorMessage() -> UILabel {
        let label = UILabel()
        label.text = "Error de conexión"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
