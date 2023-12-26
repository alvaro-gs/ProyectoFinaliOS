//
//  LoginViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 17/08/23.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isHidden = true
        if let user = Auth.auth().currentUser {
            performSegue(withIdentifier: "usuarioLogeado", sender: self.self)
        }else {
            self.view.isHidden = false
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = tfEmail.text, let password = tfPassword.text {
            Auth.auth().signIn(withEmail: email, password: password){
                (result,error) in
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "usuarioLogeado", sender: self.self)
                } else{
                    let ac = UIAlertController(title: "Error", message:"Se ha producido un error al iniciar sesión", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Aceptar", style: .default)
                    ac.addAction(action1)
                    self.present(ac, animated: true)
                }
                
            }
        }
    }
    
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        
        let ac = UIAlertController(title: "Reestablecer contraseña", message:"Ingrese su correo para recibir el enlace para restablecer la contraseña", preferredStyle: .alert)
        ac.addTextField { field in
            field.placeholder = "Correo electrónico"
            field.keyboardType = .emailAddress
        }
        
        let action1 = UIAlertAction(title: "Aceptar", style: .default){
            alertAction in
            
            if let fields = ac.textFields {
                let emailField = fields[0]
                if let email = emailField.text, !email.isEmpty {
                    Auth.auth().sendPasswordReset(withEmail: email){ (error) in
                        if let error = error {
                            let acError = UIAlertController(title: "Error", message:error.localizedDescription, preferredStyle: .alert)
                            let actionError = UIAlertAction(title: "Aceptar", style: .default)
                            acError.addAction(actionError)
                            self.present(acError,animated: true)
                        }else{
                            let acSuccess = UIAlertController(title: "Éxito", message:"El enlace para reestablecer la contraseña ha sido enviado", preferredStyle: .alert)
                            let actionSuccess = UIAlertAction(title: "Aceptar", style: .default)
                            acSuccess.addAction(actionSuccess)
                            self.present(acSuccess,animated: true)
                        }
                    }
                }
                else{
                    let acError = UIAlertController(title: "Error", message:"Favor de ingresar el correo electrónico", preferredStyle: .alert)
                    let actionError = UIAlertAction(title: "Aceptar", style: .default)
                    acError.addAction(actionError)
                    self.present(acError,animated: true)
                   
                }
            }
            
            
        }
        
        let action2 = UIAlertAction(title: "Cancelar", style: .cancel)
        ac.addAction(action1)
        ac.addAction(action2)
        
        self.present(ac, animated: true)
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = tfEmail.text, let password = tfPassword.text {
            Auth.auth().createUser(withEmail: email, password: password){
                (result,error) in
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "registro", sender: self.self)
                } else{
                    let ac = UIAlertController(title: "Error", message:"Se ha producido un error al registrar al usuario", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Aceptar", style: .default)
                    ac.addAction(action1)
                    self.present(ac, animated: true)
                }
                
            }
        }
    }
    
    
    
    // MARK: - Navigation

}
