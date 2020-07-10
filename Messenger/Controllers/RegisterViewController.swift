//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Gerard on 06/07/2020.
//  Copyright © 2020 Gerard. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
            if error != nil {
                print(error!)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
            else {
                print("Registration succesfull!")
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
            
        }
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
