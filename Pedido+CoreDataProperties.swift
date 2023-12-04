//
//  Pedido+CoreDataProperties.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 25/11/23.
//
//

import Foundation
import CoreData


extension Pedido {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pedido> {
        return NSFetchRequest<Pedido>(entityName: "Pedido")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var postalCode: Int16
    @NSManaged public var presentation: Int16
    @NSManaged public var productoId: Int64
    @NSManaged public var remainingPayment: Double
    @NSManaged public var status: Int16
    @NSManaged public var street: String?
    @NSManaged public var suburb: String?
    @NSManaged public var userId: String?
    @NSManaged public var observations: String?

}

extension Pedido : Identifiable {

}
