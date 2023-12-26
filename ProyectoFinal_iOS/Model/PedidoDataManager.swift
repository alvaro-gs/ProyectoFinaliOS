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
    
    func getAllPedidos(){
        do {
            self.pedidos = try self.context.fetch(Pedido.fetchRequest())
        }catch let error{
            print ("error: ",error)
        }
    }
    
    func getPedidosByUserId(userId: String) {
        let fetchRequest = NSFetchRequest<Pedido>(entityName: "Pedido")
        var predicate : NSPredicate?
        
        predicate = NSPredicate(format: "%K == %@",#keyPath(Pedido.userId),userId as CVarArg)
        fetchRequest.predicate = predicate
        
        do  {
            self.pedidos = try self.context.fetch(fetchRequest)
            
        } catch let error {
            print ("error: ",error.localizedDescription)
        }
    }
    
    func getPedido(at index: Int) -> Pedido{
        return pedidos[index]
    }
    
    func cancelarPedido(pedido:Pedido){
        pedido.status = 5
        do {
            try context.save()
        } catch let error {
            print("error",error.localizedDescription)
        }
    }
    
    func deletePedido(pedido:Pedido) {
        self.context.delete(pedido)
        
        do {
            try context.save()
        } catch let error {
            print("error",error.localizedDescription)
        }
    }
    
    func countPedidos() -> Int{
        return pedidos.count
    }
}
