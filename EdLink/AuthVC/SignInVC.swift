//
//  SignInVC.swift
//  EdLink
//
//  Created by Muhammad Faruuq Qayyum on 08/01/21.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signInBtnTap(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        if emailInput.text == "" || passwordInput.text == "" {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { [weak self] (success, error) in
            if error != nil {
                DispatchQueue.main.async {
                    alert.message = error!.localizedDescription
                    self?.present(alert, animated: true, completion: nil)
                    return
                }
            } else {
                print(success!.user.email!)
                self?.performSegue(withIdentifier: "signInToHome", sender: self)
            }
        }

    }

}
