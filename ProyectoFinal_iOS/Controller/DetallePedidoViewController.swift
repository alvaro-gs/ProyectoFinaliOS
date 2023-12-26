//
//  DetallePedidoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/08/23.
//

import UIKit
import SDWebImage

class DetallePedidoViewController: UIViewController {
    @IBOutlet weak var textoProducto: UILabel!
    @IBOutlet weak var imagenPedido: UIImageView!
    @IBOutlet weak var detalleTitulo: UILabel!
    @IBOutlet weak var textoDetalle: UILabel!
    @IBOutlet weak var estatusTitulo: UILabel!
    @IBOutlet weak var textoEstatus: UILabel!
    @IBOutlet weak var pagoTitulo: UILabel!
    @IBOutlet weak var textoPago: UILabel!
    @IBOutlet weak var observacionesTitulo: UILabel!
    @IBOutlet weak var textoObservaciones: UILabel!
    let scrollView = UIScrollView()
    
    
    var pedido:Pedido?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        
        textoProducto.isHidden = true
        imagenPedido.isHidden = true
        detalleTitulo.isHidden = true
        textoDetalle.isHidden = true
        estatusTitulo.isHidden = true
        textoEstatus.isHidden = true
        pagoTitulo.isHidden = true
        textoPago.isHidden = true
        observacionesTitulo.isHidden = true
        textoObservaciones.isHidden = true
        
        navigationItem.title = "Detalle del pedido"
        textoProducto.text = "Producto: " + (pedido?.name)!
        let imageURL = URL(string:(pedido?.imageURL)!)
        imagenPedido.sd_setImage(with: imageURL)
        
        let status = pedido?.status
        
        switch(status){
            case 0:
                textoEstatus.text = "Recibido"
                break
            case 1:
                textoEstatus.text = "En proceso"
                break
            case 2:
                textoEstatus.text = "Finalizado"
                break
            case 3:
                textoEstatus.text = "Enviado"
                break
            case 4:
                textoEstatus.text = "Entregado"
                break
            case 5:
                textoEstatus.text = "Cancelado"
                break
            default:
                textoEstatus.text = ""
                break
        }
        
        
        let pago = pedido?.remainingPayment
        textoPago.text = pago?.description
        
   
        if pedido?.postalCode == -1
        {
            textoDetalle.text = "Entrega en sucursal"
            
        }
        else{
            var texto = ""
            texto += "Entrega en: " + (pedido?.street)! + ", "
            texto += (pedido?.suburb)!
            texto += ", CP: " + (pedido?.postalCode.description)!
            
            if pedido?.notes != nil {
                texto += " Notas adicionales: " + (pedido?.notes)!
            }
            
            textoDetalle.text = texto
            
            if pedido?.observations != nil {
                textoObservaciones.text = pedido?.observations
            }
            else{
                textoObservaciones.text = "Sin observaciones"
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 104).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -49).isActive = true
        addScrollView()
        
    }
    
    func addScrollView() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
        stackView.addArrangedSubview(textoProducto)
        stackView.addArrangedSubview(imagenPedido)
        stackView.addArrangedSubview(detalleTitulo)
        stackView.addArrangedSubview(textoDetalle)
        stackView.addArrangedSubview(estatusTitulo)
        stackView.addArrangedSubview(textoEstatus)
        stackView.addArrangedSubview(pagoTitulo)
        stackView.addArrangedSubview(textoPago)
        stackView.addArrangedSubview(observacionesTitulo)
        stackView.addArrangedSubview(textoObservaciones)
        
        textoProducto.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:0).isActive = true
        textoProducto.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -152).isActive = true
        

        imagenPedido.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:76).isActive = true
        imagenPedido.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -76).isActive = true
        
        
        detalleTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:115).isActive = true
        detalleTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -115).isActive = true
       
        
        textoDetalle.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoDetalle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        
        
        estatusTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:164).isActive = true
        estatusTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -164).isActive = true
       

        textoEstatus.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoEstatus.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
      
    
        pagoTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:136).isActive = true
        pagoTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -136).isActive = true
      
        
        
        textoPago.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoPago.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
      
        
        observacionesTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:139).isActive = true
        observacionesTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -140).isActive = true

        
        textoObservaciones.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoObservaciones.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        
        scrollView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant:0).isActive = true
        stackView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:0).isActive = true
        stackView.topAnchor.constraint(equalTo:scrollView.topAnchor, constant:0).isActive = true
        stackView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor, constant:0).isActive = true
        
        textoProducto.isHidden = false
        imagenPedido.isHidden = false
        detalleTitulo.isHidden = false
        textoDetalle.isHidden = false
        estatusTitulo.isHidden = false
        textoEstatus.isHidden = false
        pagoTitulo.isHidden = false
        textoPago.isHidden = false
        observacionesTitulo.isHidden = false
        textoObservaciones.isHidden = false
        
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
