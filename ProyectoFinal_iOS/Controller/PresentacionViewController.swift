//
//  PresentacionViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/11/23.
//

import UIKit

class PresentacionViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         pvPresentaciones.dataSource = self
         pvPresentaciones.delegate = self
        
        tvProductoSeleccionado.text = producto?.name
        
        productoService.loadDetalleProducto(productoID: (producto?.id.description)!){ detalleProducto in
            DispatchQueue.main.async {
                if detalleProducto != nil {
                    
                    self.listaPresentaciones = detalleProducto!.presentations
                    self.pvPresentaciones.reloadAllComponents()
                    self.presentacionId = 0
                    self.totalPagar = self.listaPresentaciones[0].price
                    self.tvTotalPagar.text = "Total a pagar: " + self.totalPagar.description
                    
                }
                
            }
            
        }
         
        // Do any additional setup after loading the view.
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
        //print(presentacionId.description)
        totalPagar = listaPresentaciones[row].price
        tvTotalPagar.text = "Total a pagar: " + totalPagar.description
    }
    
    
}
