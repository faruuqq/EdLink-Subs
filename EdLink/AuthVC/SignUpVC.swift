//
//  SignUpVC.swift
//  EdLink
//
//  Created by Muhammad Faruuq Qayyum on 08/01/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var retypePassInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtnTap(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error", message: "Your password should be matched", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        
        if nameInput.text == nil || nameInput.text == "" {
            alert.message = "Please fill all the fields"
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if passwordInput.text != retypePassInput.text {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: emailInput.text!, password: passwordInput.text!) { [weak self] (success, error) in
            if error != nil {
                DispatchQueue.main.async {
                    alert.message = error!.localizedDescription
                    self?.present(alert, animated: true, completion: nil)
                    return
                }
            } else {
                let db = Firestore.firestore()
                db.collection(success!.user.email!).document("Personal").setData([
                    "id" : success!.user.uid,
                    "full-name" : self!.nameInput.text!
                ]) { (error) in
                    if error != nil {
                        alert.message = error!.localizedDescription
                        self?.present(alert, animated: true, completion: nil)
                    } else {
                        self?.performSegue(withIdentifier: "signUpToHome", sender: self)
                    }
                }
            }
        }
    }

}
