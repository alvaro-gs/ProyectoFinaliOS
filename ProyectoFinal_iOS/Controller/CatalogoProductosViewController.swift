//
//  CatalogoProductosViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 12/10/23.
//

import UIKit
import SDWebImage
import FirebaseAuth

class CatalogoProductosViewController: UIViewController {

    @IBOutlet weak var tableViewProductos: UITableView!
    
    let productoService = ProductoService()
    var productoId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewProductos.dataSource = self
        tableViewProductos.delegate = self
        
        productoService.loadProductos {
            DispatchQueue.main.async{
                self.tableViewProductos.reloadData()
            }
                
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetalleProductoViewController
        destination.productoId = productoId?.description
    }
    

}

extension CatalogoProductosViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productoService.countProductos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productoCell", for: indexPath) as! ProductoCell
        
        cell.productoName.text = productoService.getProducto(at: indexPath.row).name
        
        let imageURL = URL(string: productoService.getProducto(at: indexPath.row).image)
        
        cell.productoImage.sd_setImage(with: imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productoId = productoService.getProducto(at: indexPath.row).id
        performSegue(withIdentifier: "detalleProducto", sender: self.self)
    }
    
    
}
