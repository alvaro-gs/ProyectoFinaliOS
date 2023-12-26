//
//  ConfiguracionViewController.swift
//  ProyectoFinal_iOS
//
//  Created by Álvaro Gómez Segovia on 03/12/23.
//

import UIKit
import FirebaseAuth

class ConfiguracionViewController: UIViewController {
    
    @IBOutlet weak var tableOptions: UITableView!
    
    let cellSpacingHeight : CGFloat = 1
    
    let menuOptions : [MenuOption] = [
            MenuOption(
                title:"Configuración",
                image:"gearshape.fill")
            , MenuOption(
                title:"Domicilios de entrega",
                image:"bicycle")
            , MenuOption(
                title:"Cerrar sesión",
                image:"rectangle.portrait.and.arrow.right")
        ]

    override func viewDidLoad() {
        navigationItem.title = "Menú"
        super.viewDidLoad()
        tableOptions.delegate = self
        tableOptions.dataSource = self
        // Do any additional setup after loading the view.
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

extension ConfiguracionViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuOptions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.menuOptionLabel.text = menuOptions[indexPath.section].title
        cell.menuOptionImage.image = UIImage(systemName: menuOptions[indexPath.section].image)
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            
            do{
                try Auth.auth().signOut()
                performSegue(withIdentifier: "cerrarSesion", sender: self.self)
            }catch{
                print("error")
            }
        }
    }
    
    
}

