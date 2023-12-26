//
//  ListaPedidosViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 04/10/23.
//

import UIKit
import FirebaseAuth

class ListaPedidosViewController: UIViewController,PedidoCellDelegate {
    
    @IBOutlet weak var tableViewPedidos: UITableView!
    var pedido: Pedido?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pedidoManager: PedidoDataManager?
    var user : FirebaseAuth.User?
    
    let cellSpacingHeight : CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        tableViewPedidos.dataSource = self
        tableViewPedidos.delegate = self

        pedidoManager = PedidoDataManager(context: context)
        
        if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
            navigationItem.title = "Pedidos registrados"
            pedidoManager?.getAllPedidos()
        }
        else{
            navigationItem.title = "Mis pedidos"
            pedidoManager?.getPedidosByUserId(userId: user!.uid)
        }
        
        tableViewPedidos.reloadData()
        print(user?.displayName ?? user?.email ?? "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    @IBAction func UnWindFromNuevoPedido(segue:UIStoryboardSegue){
        let source = segue.source as! DireccionViewController
        pedido = source.pedido
        do{
            try context.save()
        }catch let error{
            print("error:", error)
        }
        if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
            pedidoManager?.getAllPedidos()
        }
        else{
            pedidoManager?.getPedidosByUserId(userId: user!.uid)
        }
        
        tableViewPedidos.reloadData()
    }
    
    @IBAction func UnWindFromEditarPedidoAdmin(segue:UIStoryboardSegue){
        let source = segue.source as! EditarPedidoAdminViewController
        pedido = source.pedido
        do{
            try context.save()
        }catch let error{
            print("error:", error)
        }
        if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
            pedidoManager?.getAllPedidos()
        }
        else{
            pedidoManager?.getPedidosByUserId(userId: user!.uid)
        }
        
        tableViewPedidos.reloadData()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detallePedido"{
            let destinatination = segue.destination as! DetallePedidoViewController
            destinatination.pedido = pedido
            
        }
        
        if segue.identifier == "editarPedido"{
            let destination = segue.destination as! NuevoPedidoViewController
            destination.pedido = pedido
            
        }
        
        if segue.identifier == "editarPedidoAdmin"{
            let destination = segue.destination as! EditarPedidoAdminViewController
            destination.pedido = pedido
        }
        
    }
    
    func button(_ button: UIButton, touchedIn cell: PedidoCell) {
        if let ix = tableViewPedidos.indexPath(for: cell) {
            pedido = pedidoManager?.getPedido(at:ix.section)
            let estatus = pedido?.status
            if button.tag == 1{
                if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
                    performSegue(withIdentifier: "editarPedidoAdmin", sender: self.self)
                }
                else{
                    if estatus == 0 {
                        performSegue(withIdentifier: "editarPedido", sender: self.self)
                    }else{
                        var message = ""
                        if estatus == 5 {
                            message = "Los pedidos cancelados ya no se pueden modificar"
                        }
                        else{
                            message = "No es posible editar este pedido porque ya se encuentra en proceso de elaboración"
                        }
                        let ac = UIAlertController(title: "Editar pedido", message:message, preferredStyle: .alert)
                        let action1 = UIAlertAction(title: "Aceptar", style: .default)
                        ac.addAction(action1)
                        self.present(ac, animated: true)
                    }
                    
                }
            }
            else{
                if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
                    let ac = UIAlertController(title: "Eliminar pedido", message:"¿Está seguro de querer eliminar este pedido?", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Aceptar", style: .destructive) {
                        alertaction in
                        
                        self.pedidoManager?.deletePedido(pedido: self.pedido!)
                        self.pedidoManager?.getAllPedidos()
                        self.tableViewPedidos.reloadData()
                       
                    }
                    let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
                    ac.addAction(action1)
                    ac.addAction(action2)
                    self.present(ac, animated: true)
                }
                else {
                    if estatus == 0 {
                        let ac = UIAlertController(title: "Cancelar pedido", message:"¿Está seguro de querer cancelar el pedido?", preferredStyle: .alert)
                        let action1 = UIAlertAction(title: "Aceptar", style: .default){
                            alertAction in
                            
                            self.pedidoManager?.cancelarPedido(pedido: self.pedido!)
                            self.pedidoManager?.getPedidosByUserId(userId: self.user!.uid )
                            self.tableViewPedidos.reloadData()
                        }
                        let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
                        ac.addAction(action1)
                        ac.addAction(action2)
                        self.present(ac, animated: true)
                    }
                    else{
                        var message = ""
                        if estatus == 5 {
                            message = "Los pedidos cancelados ya no se pueden modificar"
                            let ac = UIAlertController(title: "Cancelar pedido", message:message, preferredStyle: .alert)
                            let action1 = UIAlertAction(title: "Aceptar", style: .default)
                            ac.addAction(action1)
                            self.present(ac, animated: true)
                        }
                        else{
                            message = "¿Está seguro de querer cancelar el pedido? No se le reembolsará el anticipo"
                            let ac = UIAlertController(title: "Cancelar pedido", message:message, preferredStyle: .alert)
                            let action1 = UIAlertAction(title: "Aceptar", style: .default){
                                alertAction in
                                
                                self.pedidoManager?.cancelarPedido(pedido: self.pedido!)
                                self.pedidoManager?.getPedidosByUserId(userId: self.user!.uid )
                                self.tableViewPedidos.reloadData()
                            }
                            let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
                            ac.addAction(action1)
                            ac.addAction(action2)
                            self.present(ac, animated: true)
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
    }

}

extension ListaPedidosViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (pedidoManager?.countPedidos())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pedidoCell", for: indexPath) as! PedidoCell
        
        let imageURL = URL(string: (pedidoManager?.getPedido(at: indexPath.section).imageURL)!)
        
        cell.imagePedido.sd_setImage(with: imageURL)
        
        let status = pedidoManager?.getPedido(at: indexPath.section).status
        
        switch(status){
            case 0:
                cell.estatusPedido.text = "Recibido"
                break
            case 1:
                cell.estatusPedido.text = "En proceso"
                break
            case 2:
                cell.estatusPedido.text = "Finalizado"
                break
            case 3:
                cell.estatusPedido.text = "Enviado"
                break
            case 4:
                cell.estatusPedido.text = "Entregado"
                break
            case 5:
                cell.estatusPedido.text = "Cancelado"
                break
            default:
                cell.estatusPedido.text = ""
                break
        }
        
        cell.layer.cornerRadius = 8
        
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform segue when user touchs a cell
        pedido = pedidoManager?.getPedido(at: indexPath.section)
        
        if user?.uid == "AMufvA6zA4ZaAOWrnegGS5qyecI3"{
            performSegue(withIdentifier: "editarPedidoAdmin", sender: self.self)
        }
        else{
            performSegue(withIdentifier: "detallePedido", sender: self.self)
        }
       
    }
    
    
}
