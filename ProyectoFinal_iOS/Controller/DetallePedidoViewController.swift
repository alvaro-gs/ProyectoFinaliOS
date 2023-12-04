//
//  DetallePedidoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/08/23.
//

import UIKit
import SDWebImage

class DetallePedidoViewController: UIViewController {
    @IBOutlet weak var imagenPedido: UIImageView!
    @IBOutlet weak var textoDetalle: UILabel!
    @IBOutlet weak var textoEstatus: UILabel!
    @IBOutlet weak var textoPago: UILabel!
    
    
    var pedido:Pedido?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imageURL = URL(string:(pedido?.imageURL)!)
        imagenPedido.sd_setImage(with: imageURL)
        
        let status = pedido?.status
        if status == 0 {
            textoEstatus.text = "Recibido"
        }
        let pago = pedido?.remainingPayment
        textoPago.text = pago?.description
        
   
        if pedido?.postalCode == -1
        {
            textoDetalle.text = "Entrega en sucursal"
            
        }
        else{
            /*textoDetalle.text = "Entrega en: " + (pedido?.street)! + ", " + (pedido?.suburb)! + ", CP: " + pedido?.postalCode.description + " Observaciones adicionales: " + (pedido?.notes)!*/
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
