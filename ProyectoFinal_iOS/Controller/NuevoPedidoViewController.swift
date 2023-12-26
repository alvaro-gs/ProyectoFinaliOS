//
//  NuevoPedidoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/08/23.
//

import UIKit
import SDWebImage

class NuevoPedidoViewController: UIViewController {
    
    @IBOutlet weak var labelProductos: UILabel!
    @IBOutlet weak var pvProducto: UIPickerView!
    @IBOutlet weak var ivProducto: UIImageView!
    @IBOutlet weak var btNext: UIButton!
    
    var producto: Producto?
    let productoService = ProductoService()
    var pedido: Pedido?
    
    let buttonReload: UIButton = Utils.createButton(title:"Recargar", color: UIColor(named: "rojo")!)
        
    let progressBar: UIActivityIndicatorView = Utils.createProgressBar(color:UIColor(named: "azulFondo")!)
    
    let errorMessage: UILabel = Utils.createErrorMessage()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if pedido == nil {
            navigationItem.title = "Nuevo pedido"
        }
        else{
            navigationItem.title = "Actualizar pedido"
        }
        
        pvProducto.dataSource = self
        pvProducto.delegate = self
        
        labelProductos.isHidden = true
        pvProducto.isHidden = true
        ivProducto.isHidden = true
        btNext.isHidden = true
        
        load()
        
    }
    
    private func load () {
        view.addSubview(progressBar)
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressBar.startAnimating()
        if InternetMonitor.shared.internetStatus{
            productoService.loadProductos {
                DispatchQueue.main.async{
                    
                    self.progressBar.stopAnimating()
                    
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
                    
                    self.labelProductos.isHidden = false
                    self.pvProducto.isHidden = false
                    self.ivProducto.isHidden = false
                    self.btNext.isHidden = false
                    
                }
                
            }
        }else{
            progressBar.stopAnimating()
            addNetworkConstraints()
        }
    }
    
    
    private func addNetworkConstraints(){
        view.addSubview(buttonReload)
        buttonReload.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonReload.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        buttonReload.addTarget(self, action: #selector(reload), for: .touchUpInside)
        
        view.addSubview(errorMessage)
        errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorMessage.topAnchor.constraint(equalTo: buttonReload.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc private func reload() {
        progressBar.removeFromSuperview()
        errorMessage.removeFromSuperview()
        buttonReload.removeFromSuperview()
        load()
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

