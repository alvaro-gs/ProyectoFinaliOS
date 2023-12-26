//
//  PresentacionViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/11/23.
//

import UIKit

class PresentacionViewController: UIViewController {

    @IBOutlet weak var labelPresentaciones: UILabel!
    @IBOutlet weak var tvProductoSeleccionado: UILabel!
    @IBOutlet weak var pvPresentaciones: UIPickerView!
    @IBOutlet weak var tvTotalPagar: UILabel!
    @IBOutlet weak var btSend: UIButton!
    
    var producto: Producto?
    let productoService = ProductoService()
    private var listaPresentaciones : [Presentations] = []
    //var presentacion : Presentations?
    var presentacionId = -1
    var totalPagar = 0.0
    var pedido: Pedido?
    
    let buttonReload: UIButton = Utils.createButton(title:"Recargar", color: UIColor(named: "rojo")!)
        
    let progressBar: UIActivityIndicatorView = Utils.createProgressBar(color:UIColor(named: "azulFondo")!)
    
    let errorMessage: UILabel = Utils.createErrorMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Elige una presentación"
        
        pvPresentaciones.dataSource = self
        pvPresentaciones.delegate = self
        
        labelPresentaciones.isHidden = true
        tvProductoSeleccionado.isHidden = true
        pvPresentaciones.isHidden = true
        tvTotalPagar.isHidden = true
        btSend.isHidden = true

        load()
    
    }
    
    private func load (){
        view.addSubview(progressBar)
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressBar.startAnimating()
        if InternetMonitor.shared.internetStatus {
            productoService.loadDetalleProducto(productoID: (producto?.id.description)!){ detalleProducto in
                DispatchQueue.main.async {
                    
                    if detalleProducto != nil {
                        
                        self.progressBar.stopAnimating()
                        
                        self.tvProductoSeleccionado.text = detalleProducto?.name
                        self.listaPresentaciones = detalleProducto!.presentations
                        self.pvPresentaciones.reloadAllComponents()
                        self.presentacionId = 0
                        self.totalPagar = self.listaPresentaciones[0].price
                        self.tvTotalPagar.text = "Total a pagar: " + self.totalPagar.description
                        
                        self.labelPresentaciones.isHidden = false
                        self.tvProductoSeleccionado.isHidden = false
                        self.pvPresentaciones.isHidden = false
                        self.tvTotalPagar.isHidden = false
                        self.btSend.isHidden = false
                        
                    }
                    
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! DireccionViewController
        destination.producto = producto
        destination.presentacionId = presentacionId
        destination.totalPagar = totalPagar
        if pedido != nil {
            destination.pedido = pedido
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    @IBAction func btNextClicked(_ sender: Any) {
        performSegue(withIdentifier: "direcciones", sender: self.self)
    }
    
    
    
    
    

}

extension PresentacionViewController :  UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaPresentaciones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listaPresentaciones[row].desc
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presentacionId = row
        totalPagar = listaPresentaciones[row].price
        tvTotalPagar.text = "Total a pagar: " + totalPagar.description
    }
    
    
}
