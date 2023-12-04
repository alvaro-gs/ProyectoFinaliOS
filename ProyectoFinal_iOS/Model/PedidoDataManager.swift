//
//  PedidoDataManager.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 04/10/23.
//

import Foundation
import CoreData

class PedidoDataManager{
    private var pedidos: [Pedido] = []
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetch(){
        do {
            self.pedidos = try self.context.fetch(Pedido.fetchRequest())
        }catch let error{
            print ("error: ",error)
        }
    }
    
    func getPedido(at index: Int) -> Pedido{
        return pedidos[index]
    }
    
    func countPedidos() -> Int{
        return pedidos.count
    }
}
