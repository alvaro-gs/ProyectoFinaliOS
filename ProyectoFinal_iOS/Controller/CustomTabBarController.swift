//
//  CustomTabBarController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 04/12/23.
//

import UIKit
import FirebaseAuth

class CustomTabBarController: UITabBarController,UITabBarControllerDelegate {

    var user : FirebaseAuth.User?
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var bandera = true
        switch (tabBarController.tabBar.selectedItem?.tag){
            case 0:
                bandera = true
                break
            case 1:
                if user ==  nil{
                    bandera = false
                }
                else{
                    bandera = true
                }
                break
            case 2:
                if user ==  nil{
                    bandera = false
                }
                else{
                    bandera = true
                }
                break
            default:
                bandera = false
                break
        }
        if bandera == false{
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
        return bandera
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
