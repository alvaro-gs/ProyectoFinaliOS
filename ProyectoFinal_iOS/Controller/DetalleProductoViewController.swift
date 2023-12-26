//
//  DetelleProductoViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 19/10/23.
//

import UIKit
import SDWebImage
import FirebaseAuth

class DetalleProductoViewController: UIViewController {


    @IBOutlet weak var textoProducto: UILabel!
    @IBOutlet weak var descripcionTitulo: UILabel!
    @IBOutlet weak var textoDescripcion: UILabel!
    @IBOutlet weak var tipoTitulo: UILabel!
    @IBOutlet weak var textoTipo: UILabel!
    @IBOutlet weak var detallesTitulo: UILabel!
    @IBOutlet weak var textoPresentaciones: UILabel!
    @IBOutlet weak var imagenProducto: UIImageView!
    @IBOutlet weak var btOrder: UIButton!
    let scrollView = UIScrollView()
    
    var productoId = ""
    var producto: Producto?
    let productoService = ProductoService()
    var detalleProducto: DetalleProducto?
    var user: FirebaseAuth.User?
    
    let buttonReload: UIButton = Utils.createButton(title:"Recargar", color: UIColor(named: "rojo")!)
        
    let progressBar: UIActivityIndicatorView = Utils.createProgressBar(color:UIColor(named: "azulFondo")!)
    
    let errorMessage: UILabel = Utils.createErrorMessage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
       
        navigationItem.title = "Detalle del producto"
        user = Auth.auth().currentUser
        productoId = (producto?.id.description)!
        
        textoProducto.isHidden = true
        descripcionTitulo.isHidden = true
        textoDescripcion.isHidden = true
        tipoTitulo.isHidden = true
        textoTipo.isHidden = true
        detallesTitulo.isHidden = true
        textoPresentaciones.isHidden = true
        imagenProducto.isHidden = true
        btOrder.isHidden = true
        
        load()
        
    }
    
    private func load(){
        view.addSubview(progressBar)
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressBar.startAnimating()
        if InternetMonitor.shared.internetStatus {
            productoService.loadDetalleProducto(productoID:productoId){ detalleProducto in
                DispatchQueue.main.async {
                    
                    if detalleProducto != nil{
                        
                        self.progressBar.stopAnimating()
                        
                        //self.detalleProducto = detalleProducto
                        
                        self.textoProducto.text = detalleProducto?.name
                        
                        let imageURL = URL(string: (detalleProducto?.image)!)
                        
                        self.imagenProducto.sd_setImage(with: imageURL)
                        
                        self.textoDescripcion.text = detalleProducto?.long_desc
                           
                        let typeId = detalleProducto?.type_id
                            
                        switch typeId {
                        case "1":
                            self.textoTipo.text = "Pasteles/Roscas"
                        case "2":
                            self.textoTipo.text = "Panques"
                        case "3":
                            self.textoTipo.text = "Mufffins/Cupcakes"
                        case "4":
                            self.textoTipo.text = "Galletas"
                        case "5":
                            self.textoTipo.text = "Otros"
                        default:
                            self.textoTipo.text = "Error"
                        }
                            
                        let listaPresentaciones  = detalleProducto?.presentations
                        var textoPresentaciones = ""
                        for presentacion in listaPresentaciones! {
                            textoPresentaciones += presentacion.desc + ":" + presentacion.price.description + "\n"
                        }
                            
                        self.textoPresentaciones.text = textoPresentaciones
                        
                        self.addScrollView()
                    }
                    else{
                        //print("lelele")
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
    
    
    func addScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 104).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -49).isActive = true
        
    
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.addArrangedSubview(textoProducto)
        stackView.addArrangedSubview(imagenProducto)
        stackView.addArrangedSubview(descripcionTitulo)
        stackView.addArrangedSubview(textoDescripcion)
        stackView.addArrangedSubview(tipoTitulo)
        stackView.addArrangedSubview(textoTipo)
        stackView.addArrangedSubview(detallesTitulo)
        stackView.addArrangedSubview(textoPresentaciones)
        stackView.addArrangedSubview(btOrder)
        
        
        textoProducto.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:0).isActive = true
        textoProducto.trailingAnchor.constraint(equalTo:stackView.trailingAnchor,constant:-78).isActive = true
        
        
        imagenProducto.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:76).isActive = true
        imagenProducto.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -76).isActive = true
        
        
        descripcionTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:77).isActive = true
        descripcionTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -77).isActive = true
        
        
        textoDescripcion.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoDescripcion.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        
        
        tipoTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:120).isActive = true
        tipoTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -120).isActive = true
    
    
        textoTipo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoTipo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        
        
        detallesTitulo.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:39).isActive = true
        detallesTitulo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -39).isActive = true
       
        
        textoPresentaciones.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:110).isActive = true
        textoPresentaciones.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -110).isActive = true
        

        
        btOrder.leadingAnchor.constraint(equalTo:stackView.leadingAnchor,constant:153.33).isActive = true
        btOrder.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -153.33).isActive = true
        
        scrollView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant:0).isActive = true
        stackView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:0).isActive = true
        stackView.topAnchor.constraint(equalTo:scrollView.topAnchor, constant:0).isActive = true
        stackView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor, constant:0).isActive = true
        
        self.textoProducto.isHidden = false
        self.descripcionTitulo.isHidden = false
        self.textoDescripcion.isHidden = false
        self.tipoTitulo.isHidden = false
        self.textoTipo.isHidden = false
        self.detallesTitulo.isHidden = false
        self.textoPresentaciones.isHidden = false
        self.imagenProducto.isHidden = false
        self.btOrder.isHidden = false
    }
    
    @IBAction func ordenarClick(_ sender: Any) {
        if user != nil {
            performSegue(withIdentifier: "nuevoPedidoConProducto", sender: self.self)
        }
        else{
            let ac = UIAlertController(title: "Inciar sesión", message:"Se requiere iniciar sesión para acceder a esta sección", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Aceptar", style: .default) {
                alertaction in
                
                self.performSegue(withIdentifier: "requiereLogin", sender: self.self)
                
            }
            let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
            ac.addAction(action1)
            ac.addAction(action2)
            self.present(ac, animated: true)
        }
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier ==  "nuevoPedidoConProducto" {
            let destination = segue.destination as! PresentacionViewController
            destination.producto = producto
        }
        
    }
    
    
    

}
