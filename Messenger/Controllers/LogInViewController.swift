//
//  LogInViewController.swift
//  Messenger
//
//  Created by Gerard on 06/07/2020.
//  Copyright © 2020 Gerard. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
            if error != nil {
                self.passwordTextField.text = ""
                self.emailTextField.text = ""
                print(error!)
            }
            else {
                print("log In Succesfull")
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
