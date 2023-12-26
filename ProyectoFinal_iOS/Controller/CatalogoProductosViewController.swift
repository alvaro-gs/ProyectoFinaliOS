//
//  CatalogoProductosViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 12/10/23.
//

import UIKit
import SDWebImage
import FirebaseAuth

class CatalogoProductosViewController: UIViewController {

    @IBOutlet weak var tableViewProductos: UITableView!
    
    let productoService = ProductoService()
    var producto: Producto?
    
    let cellSpacingHeight : CGFloat = 1
    
    let buttonReload: UIButton = Utils.createButton(title:"Recargar", color: UIColor(named: "rojo")!)
        
    let progressBar: UIActivityIndicatorView = Utils.createProgressBar(color:UIColor(named: "azulFondo")!)
    
    let errorMessage: UILabel = Utils.createErrorMessage()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Productos disponibles"
        tableViewProductos.dataSource = self
        tableViewProductos.delegate = self
        
        load()
        
    }

    private func load () {
        view.addSubview(progressBar)
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressBar.startAnimating()
        if InternetMonitor.shared.internetStatus {
            productoService.loadProductos {
                DispatchQueue.main.async{
                    self.progressBar.stopAnimating()
                    self.tableViewProductos.reloadData()
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
        let destination = segue.destination as! DetalleProductoViewController
        destination.producto = producto
    }
    

}

extension CatalogoProductosViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productoService.countProductos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productoCell", for: indexPath) as! ProductoCell
        
        cell.productoName.text = productoService.getProducto(at: indexPath.section).name
        
        let imageURL = URL(string: productoService.getProducto(at: indexPath.section).image)
        
        cell.productoImage.sd_setImage(with: imageURL)
        
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        producto = productoService.getProducto(at: indexPath.section)
        performSegue(withIdentifier: "detalleProducto", sender: self.self)
    }
    
    
}
