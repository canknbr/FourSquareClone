//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Can Kanbur on 4.04.2023.
//

import UIKit
import Parse
class SignUpVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(title: "error", message: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(title: "Error", message: "Username / Password")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)

                }
            }
            
        }else{
            makeAlert(title: "Error", message: "Username / Password?")
        }
    }
    
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true)
    }
}

