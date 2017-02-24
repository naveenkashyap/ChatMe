//
//  LoginViewController.swift
//  ChatMe
//
//  Created by Naveen Kashyap on 2/23/17.
//  Copyright © 2017 Naveen Kashyap. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    var userExistsAlertController: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userExistsAlertController = UIAlertController(title: "Error!", message: "User with this email already exists!", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        userExistsAlertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = emailTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (wasSuccessful: Bool, error: Error?) in
            if (wasSuccessful) {
                print("user created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.present(self.userExistsAlertController, animated: true);
            }
        }
    }

    
    @IBAction func onLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
