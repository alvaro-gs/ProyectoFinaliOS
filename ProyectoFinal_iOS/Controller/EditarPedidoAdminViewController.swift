//
//  EditarPedidoAdminViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 10/12/23.
//

import UIKit

class EditarPedidoAdminViewController: UIViewController {
    
    @IBOutlet weak var textoProducto: UILabel!
    @IBOutlet weak var imagenPedido: UIImageView!
    @IBOutlet weak var detalleTitulo: UILabel!
    @IBOutlet weak var textoDetalle: UILabel!
    @IBOutlet weak var estatusTitulo: UILabel!
    @IBOutlet weak var pvEstatus: UIPickerView!
    @IBOutlet weak var pagoTitulo: UILabel!
    @IBOutlet weak var textoPago: UILabel!
    @IBOutlet weak var observacionesTitulo: UILabel!
    @IBOutlet weak var ingresaObservaciones: UITextField!
    @IBOutlet weak var btGuardar: UIButton!
    let scrollView = UIScrollView()
    
    var listaEstatus = ["Recibido","En proceso","Finalizado","Enviado","Entregado","Cancelado"]
    var estatusId = 0
    
    
    var pedido:Pedido?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)

        textoProducto.isHidden = true
        imagenPedido.isHidden = true
        detalleTitulo.isHidden = true
        textoDetalle.isHidden = true
        estatusTitulo.isHidden = true
        pvEstatus.isHidden = true
        pagoTitulo.isHidden = true
        textoPago.isHidden = true
        observacionesTitulo.isHidden = true
        ingresaObservaciones.isHidden = true
        
        navigationItem.title = "Editar pedido : Administrador "
        pvEstatus.delegate = self
        pvEstatus.dataSource = self
        let estatus = Int(pedido!.status)
        pvEstatus.selectRow(estatus, inComponent: 0, animated: true)
                
        
        textoProducto.text = "Producto: " + (pedido?.name)!
        let imageURL = URL(string:(pedido?.imageURL)!)
        imagenPedido.sd_setImage(with: imageURL)
        
        
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
                texto += " Observaciones adicionales: " + (pedido?.notes)!
            }
            
            textoDetalle.text = texto
            
            if pedido?.observations != nil {
                ingresaObservaciones.text = pedido?.observations
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
        stackView.addArrangedSubview(pvEstatus)
        stackView.addArrangedSubview(pagoTitulo)
        stackView.addArrangedSubview(textoPago)
        stackView.addArrangedSubview(observacionesTitulo)
        stackView.addArrangedSubview(ingresaObservaciones)
        stackView.addArrangedSubview(btGuardar)
        
        textoProducto.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:0).isActive = true
        textoProducto.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -152).isActive = true
        

        imagenPedido.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:76).isActive = true
        imagenPedido.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -76).isActive = true
        
        
        detalleTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:115).isActive = true
        detalleTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -115).isActive = true
       
        
        textoDetalle.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoDetalle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        
        
        estatusTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:112).isActive = true
        estatusTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -113).isActive = true
       

        pvEstatus.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:16).isActive = true
        pvEstatus.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16).isActive = true
      
    
        pagoTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:136).isActive = true
        pagoTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -136).isActive = true
      
        
        
        textoPago.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoPago.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
      
        
        observacionesTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:139).isActive = true
        observacionesTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -140).isActive = true

        
        ingresaObservaciones.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:16).isActive = true
        ingresaObservaciones.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16).isActive = true
        
        btGuardar.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:154).isActive = true
        btGuardar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -153).isActive = true
        
        
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
        pvEstatus.isHidden = false
        pagoTitulo.isHidden = false
        textoPago.isHidden = false
        observacionesTitulo.isHidden = false
        ingresaObservaciones.isHidden = false
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ListaPedidosViewController
        let estatus = Int16(estatusId)
        let observations = ingresaObservaciones.text
        pedido?.status = estatus
        pedido?.observations = observations
        destination.pedido = pedido
    }
    
    
    @IBAction func btGuardarClicked(_ sender: Any) {
        
        let ac = UIAlertController(title: "Guardar cambios", message:"¿Los datos son correctos?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Aceptar", style: .default) {
            alertaction in
            
            self.performSegue(withIdentifier: "unwindEditarAdmin", sender: self.self)
            
           
        }
        let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
        ac.addAction(action1)
        ac.addAction(action2)
        self.present(ac, animated: true)
        
    }
}

extension EditarPedidoAdminViewController :  UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaEstatus.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listaEstatus[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        estatusId = row
    }
    
    
}
