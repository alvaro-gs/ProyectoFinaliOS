//
//  NuevoPedidoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/08/23.
//

import UIKit
import SDWebImage

class NuevoPedidoViewController: UIViewController {
    
    @IBOutlet weak var pvProducto: UIPickerView!
    @IBOutlet weak var ivProducto: UIImageView!
    @IBOutlet weak var btNext: UIButton!
    var producto: Producto?
    let productoService = ProductoService()
    var pedido: Pedido?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pvProducto.dataSource = self
        pvProducto.delegate = self
        
        productoService.loadProductos {
            DispatchQueue.main.async{
                self.pvProducto.reloadAllComponents()
                
                if (self.pedido == nil){
                    self.producto = self.productoService.getProducto(at: 0)
                    self.pvProducto.selectRow(0, inComponent: 0, animated: true)
                }
                else{
                    let produdctoId = Int(self.pedido!.productoId)
                    self.producto = self.productoService.getProductoById(produdctoId)
                    // Ver como arreglar esto despues
                    self.pvProducto.selectRow((produdctoId - 1), inComponent: 0, animated: true)
                    
                }
                
                
                let imageURL = URL(string: self.producto!.image)
                self.ivProducto.sd_setImage(with: imageURL)
                
            }
                
        }
        
        
    }
    
    @IBAction func btNextClicked(_ sender: Any) {
        performSegue(withIdentifier: "presentaciones", sender: self.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PresentacionViewController
        destination.producto = producto
        if pedido != nil{
            destination.pedido = pedido
        }
       
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
   
}


extension NuevoPedidoViewController :  UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return productoService.countProductos()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return productoService.getProducto(at: row).name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        producto = productoService.getProducto(at: row)
        let imageURL = URL(string: producto!.image)
        ivProducto.sd_setImage(with: imageURL)
        //print(producto?.name ?? "")
    }
    
    
}

