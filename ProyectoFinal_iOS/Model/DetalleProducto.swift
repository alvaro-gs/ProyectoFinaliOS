//
//  DetalleProducto.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 12/10/23.
//

import Foundation

struct DetalleProducto: Codable{
    let name: String
    let image: String
    let long_desc: String
    let type_id : String
    let presentations : [Presentations]
}

struct Presentations : Codable{
    let desc: String
    let price: Double
}
