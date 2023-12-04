//
//  ProductoService.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 12/10/23.
//

import Foundation

class ProductoService{
    private var productos: [Producto] = []
    
    func countProductos () -> Int {
        return productos.count
    }
    
    func getProducto(at index: Int) -> Producto {
        return productos[index]
    }
    
    func getProductoById(_ id: Int) -> Producto{
        return productos.first(where: {$0.id == id })!
        
    }
    
    func loadProductos(completion: @escaping () -> Void){
        let url  = URL(string: Constants.apiBaseURL + Constants.catalogoURL)!
        
        let session = URLSession.shared
        var httpResponse = HTTPURLResponse()
        
        // Creates a data task with a URL request
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check response
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Invalid response")
                httpResponse = (response as? HTTPURLResponse)!
                print("statusCode: ", httpResponse.statusCode)
                return
            }
            
            // Check if there is any data
            guard let data = data else {
                print("No data received")
                return
            }
            
            do{
                
                let decodedResponse = try JSONDecoder().decode([Producto].self, from: data)
                for producto in decodedResponse{
                    self.productos.append(producto)
                }
                
            } catch let error{
                
                print("JSON parsing error: \(error)")
                
            }
            completion()
        }
        // Start the task
        task.resume()
    
    }
    
    func loadDetalleProducto(productoID: String,completion: @escaping (DetalleProducto?) -> Void) {
        
        let url  = URL(string: Constants.apiBaseURL + Constants.detalleUTL + productoID)!
        let session = URLSession.shared
        var httpResponse = HTTPURLResponse()
        
        // Creates a data task with a URL request
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check response
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Invalid response")
                httpResponse = (response as? HTTPURLResponse)!
                print("statusCode: ", httpResponse.statusCode)
                return
            }
            
            // Check if there is any data
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do{
                
                let decodedResponse = try JSONDecoder().decode(DetalleProducto.self, from: data)
                completion(decodedResponse)
                
                
            } catch let error{
                completion(nil)
                print("JSON parsing error: \(error)")
                
            }
            
        }
        task.resume()
    }
    
}
