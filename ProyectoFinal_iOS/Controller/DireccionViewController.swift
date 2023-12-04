//
//  DireccionViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/11/23.
//

import UIKit

class DireccionViewController: UIViewController {
    
    @IBOutlet weak var rbSucursal: UIButton!
    @IBOutlet weak var rbDomicilio: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var enterStreet: UITextField!
    @IBOutlet weak var suburbLabel: UILabel!
    @IBOutlet weak var enterSunurb: UITextField!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var enterPostalCode: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var enterNotes: UITextField!
    
    var producto : Producto?
    var totalPagar : Double?
    var presentacionId : Int?
    var pedido: Pedido?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pedidoManager: PedidoDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rbDomicilio.isSelected = false
        rbSucursal.isSelected = false
        titleLabel.isHidden = true
        streetLabel.isHidden = true
        enterStreet.isHidden = true
        suburbLabel.isHidden = true
        enterSunurb.isHidden = true
        postalCodeLabel.isHidden = true
        enterPostalCode.isHidden = true
        notesLabel.isHidden = true
        enterNotes.isHidden = true
         
         
        // Do any additional setup after loading the view.
    }
    
    
    
     @IBAction func rbAction(_ sender: UIButton) {
         if sender.tag == 2 {
             rbDomicilio.isSelected = true
             rbSucursal.isSelected = false
             titleLabel.isHidden = false
             streetLabel.isHidden = false
             enterStreet.isHidden = false
             suburbLabel.isHidden = false
             enterSunurb.isHidden = false
             postalCodeLabel.isHidden = false
             enterPostalCode.isHidden = false
             notesLabel.isHidden = false
             enterNotes.isHidden = false
         }
         else if sender.tag == 1 {
             rbDomicilio.isSelected = false
             rbSucursal.isSelected = true
             titleLabel.isHidden = true
             streetLabel.isHidden = true
             enterStreet.isHidden = true
             suburbLabel.isHidden = true
             enterSunurb.isHidden = true
             postalCodeLabel.isHidden = true
             enterPostalCode.isHidden = true
             notesLabel.isHidden = true
             enterNotes.isHidden = true
         }
     }
     
     
     // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if pedido == nil{
            pedido = Pedido (context: context)
        }
        let destination = segue.destination as! ListaPedidosViewController
        pedido?.userId = ""
        pedido?.name = producto?.name
        pedido?.imageURL = producto?.image
        let productoId = Int64(producto!.id)
        pedido?.productoId = productoId
        pedido?.status = 0
        pedido?.remainingPayment = (totalPagar ?? 0) / 2
        let aux = Int16(presentacionId!)
        pedido?.presentation = aux
         if rbDomicilio.isSelected{
             pedido?.street = enterStreet.text
             pedido?.suburb = enterSunurb.text
             pedido?.postalCode = Int16(enterPostalCode.text!)!
             pedido?.notes = enterNotes.text
     
         }
         
         else{
             pedido?.street = ""
             pedido?.suburb = ""
             pedido?.postalCode = -1
             pedido?.notes = ""

             
         }
         
         destination.pedido = pedido
         
         
     }
     
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
         return validateFields()
     }
     
     func validateFields() -> Bool {
         var streetFlag = false
         var suburbFlag = false
         var cpFlag = false
         var flag = false
         if rbDomicilio.isSelected{
             
             if enterStreet.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty == false{
                 streetFlag = true
             }else{
                 cpFlag = false
             }
             
             if enterSunurb.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty == false {
                 suburbFlag = true
             }else{
                 cpFlag = false
             }
             
             if enterPostalCode.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty == false {
                 let cuenta = enterPostalCode.text?.trimmingCharacters(in: CharacterSet.whitespaces).count ?? 0
                 if cuenta == 5{
                     cpFlag = true
                 }else{
                     cpFlag = false
                 }
                 
             }else{
                 cpFlag = false
             }
             
            flag = streetFlag && suburbFlag && cpFlag
             print (flag.description)
             return flag
         }
         
         if rbSucursal.isSelected{
             flag = true
             print (flag.description)
             return flag
         }
         flag = false
         print (flag.description)
         return flag
     }

     
    

}
