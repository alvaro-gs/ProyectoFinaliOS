//
//  ListaPedidosViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 04/10/23.
//

import UIKit

class ListaPedidosViewController: UIViewController,PedidoCellDelegate {
    
    @IBOutlet weak var tableViewPedidos: UITableView!
    var pedido: Pedido?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pedidoManager: PedidoDataManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPedidos.dataSource = self
        tableViewPedidos.delegate = self

        pedidoManager = PedidoDataManager(context: context)
        pedidoManager?.fetch() //mover esto a otro metodo
        tableViewPedidos.reloadData()
        //print("a")
        //print((pedidoManager?.countPedidos().description)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("b")
    }
    
    
    
    @IBAction func UnWindFromNuevoPedido(segue:UIStoryboardSegue){
        let source = segue.source as! DireccionViewController
        pedido = source.pedido
        do{
            try context.save()
        }catch let error{
            print("error:", error)
        }
        pedidoManager?.fetch()
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func button(_ button: UIButton, touchedIn cell: PedidoCell) {
        if let ix = tableViewPedidos.indexPath(for: cell) {
            pedido = pedidoManager?.getPedido(at:ix.row)
            if button.tag == 1{
                performSegue(withIdentifier: "editarPedido", sender: self.self)
                
            }
            else{
                let ac = UIAlertController(title: "Eliminar pedido", message:"¿Está seguro de querer eliminar este pedido?", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Aceptar", style: .destructive) {
                    alertaction in
                    
                    self.context.delete(self.pedido!)
                    self.pedidoManager?.fetch()
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

extension ListaPedidosViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pedidoManager?.countPedidos())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pedidoCell", for: indexPath) as! PedidoCell
        
        let imageURL = URL(string: (pedidoManager?.getPedido(at: indexPath.row).imageURL)!)
        
        cell.imagePedido.sd_setImage(with: imageURL)
        
        let status = pedidoManager?.getPedido(at: indexPath.row).status
        if status == 0 {
            cell.estatusPedido.text = "Recibido"
        }
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform segue when user touchs a cell
        //pedido = pedidoManager?.getPedido(at: indexPath.row)
        //performSegue(withIdentifier: "detallePedido", sender: self.self)
    }
    
    
}
