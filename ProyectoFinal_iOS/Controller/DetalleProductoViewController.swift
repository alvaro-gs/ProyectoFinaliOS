//
//  DetelleProductoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 19/10/23.
//

import UIKit

class DetalleProductoViewController: UIViewController {

    
    @IBOutlet weak var textoDescripcion: UILabel!
    @IBOutlet weak var textoTipo: UILabel!
    @IBOutlet weak var textoPresentaciones: UILabel!
    
    private var productoId: String?
    private var detalleProducto: DetalleProducto?
    let productoService = ProductoService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productoService.loadDetalleProducto(productoID:productoId!){ datosProducto in
            DispatchQueue.main.async {
                if datosProducto != nil{
                    self.detalleProducto = datosProducto
                }
            }
        }
        // Do any additional setup after loading the view.
        if detalleProducto != nil {
            textoDescripcion.text = detalleProducto?.long_desc
            
            var typeId = detalleProducto?.long_desc
            
            switch typeId {
            case "1":
                textoDescripcion.text = "Pasteles/Roscas"
            case "2":
                textoDescripcion.text = "Panques"
            case "3":
                textoDescripcion.text = "Mufffins/Cupcakes"
            case "4":
                textoDescripcion.text = "Galletas"
            case "5":
                textoDescripcion.text = "Otros"
            default:
                textoDescripcion.text = "Error"
            }
            
            var listaPresentaciones  = detalleProducto?.presentations
            var textoPresentaciones = ""
            for presentacion in listaPresentaciones! {
                textoPresentaciones += presentacion.desc + ":" + presentacion.price.description
            }
            
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
