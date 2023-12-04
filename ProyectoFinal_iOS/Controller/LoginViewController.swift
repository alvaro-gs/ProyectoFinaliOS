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
            print(user.email ?? "")
            performSegue(withIdentifier: "usuarioLogeado", sender: self.self)
        }else {
            print("No user")
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
                    print(error?.localizedDescription)
                }
                
            }
        }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = tfEmail.text, let password = tfPassword.text {
            Auth.auth().createUser(withEmail: email, password: password){
                (result,error) in
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "register", sender: self.self)
                } else{
                    let ac = UIAlertController(title: "Error", message:"Se ha producido un error al registrar al usuario", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "Aceptar", style: .default)
                    ac.addAction(action1)
                    self.present(ac, animated: true)
                }
                
            }
        }
    }
    
    @IBAction func catalogPressed(_ sender: UIButton) {
    }
    
    // MARK: - Navigation

}
