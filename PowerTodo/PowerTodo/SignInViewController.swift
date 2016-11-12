//
//  ViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/20/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    enum AlertControllerTitles: String{
        case incorretCredentials = "Oops"
    }
    
    enum AlertControllerMessages: String {
        case incorrectCredentials = "Senha ou Email incorretos majestade"
        case incompleteCredentials = "Tem coisa faltando no email ou senha"
    }
    
    enum AlertTitleForButtons: String {
        case incorrectCredentials = "Ok, vou tentar de novo"
        case incompleteCredentials = "Ok, vou arrumar"
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func signInButton(_ sender: AnyObject) {
        self.handleLogin()
    }
    @IBAction func ForgotPasswordButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "recoverPasswordSegue", sender: self)
    }
    @IBAction func signUpButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    
    func handleLogin(){
        
        if((self.emailTxtField.text?.characters.count)! < 6 || (self.passwordTextField.text?.characters.count)! < 8 ){
           self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incompleteCredentials.rawValue, titleButton: AlertTitleForButtons.incompleteCredentials.rawValue)
        }else{
        
        let user: User = User(
            name: "",
            email: self.emailTxtField.text!,
            password: self.passwordTextField.text!
        )
        
        if(/*user.signIn()*/ user.email.characters.count > 1){
            self.performSegue(withIdentifier: "fromSignToHomeSegue", sender: self)
        }else{
            self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incorrectCredentials.rawValue, titleButton: AlertTitleForButtons.incorrectCredentials.rawValue)
        }
        }
    }
    
    
    func buildAlert(titleController: String,
                    messageController: String,
                    titleButton: String){
        let alert = UIAlertController(title: titleController, message: messageController, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleButton, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}

