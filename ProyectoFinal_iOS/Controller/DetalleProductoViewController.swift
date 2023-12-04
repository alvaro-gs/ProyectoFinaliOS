//
//  DetelleProductoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 19/10/23.
//

import UIKit
import SDWebImage

class DetalleProductoViewController: UIViewController {

    
    @IBOutlet weak var textoDescripcion: UILabel!
    @IBOutlet weak var textoTipo: UILabel!
    @IBOutlet weak var textoPresentaciones: UILabel!
    @IBOutlet weak var imagenProducto: UIImageView!
    
    var productoId: String?
    let productoService = ProductoService()
    var detalleProducto: DetalleProducto?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Detalle del producto"
        productoService.loadDetalleProducto(productoID:productoId!){ detalleProducto in
            DispatchQueue.main.async {
                
                if detalleProducto != nil{
                    
                
                    self.detalleProducto = detalleProducto
                    
                    let imageURL = URL(string: (detalleProducto?.image)!)
                    
                    self.imagenProducto.sd_setImage(with: imageURL)
                    
                    self.textoDescripcion.text = detalleProducto?.long_desc
                       
                    var typeId = detalleProducto?.type_id
                        
                    switch typeId {
                    case "1":
                        self.textoTipo.text = "Pasteles/Roscas"
                    case "2":
                        self.textoTipo.text = "Panques"
                    case "3":
                        self.textoTipo.text = "Mufffins/Cupcakes"
                    case "4":
                        self.textoTipo.text = "Galletas"
                    case "5":
                        self.textoTipo.text = "Otros"
                    default:
                        self.textoTipo.text = "Error"
                    }
                        
                    var listaPresentaciones  = detalleProducto?.presentations
                    var textoPresentaciones = ""
                    for presentacion in listaPresentaciones! {
                        textoPresentaciones += presentacion.desc + ":" + presentacion.price.description
                    }
                        
                        
                    self.textoPresentaciones.text = textoPresentaciones
                    
                    print("B")
                    
                    
                                        
                }
            }
        }
        
        
        
        // Do any additional setup after loading the view.
        print("A")
    }
    
    
    
    @IBAction func ordenarClick(_ sender: Any) {
        print((self.detalleProducto?.name)!)
        performSegue(withIdentifier: "nuevoPedidoConProducto", sender: self.self)

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    

}
