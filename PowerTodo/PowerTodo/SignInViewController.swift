//
//  ViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/20/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

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
        self.showActivityIndicatory(uiView: self.view)
        //let disableMyButton = sender as? UIButton
        //disableMyButton?.isEnabled = false
        
    }
    @IBAction func ForgotPasswordButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "recoverPasswordSegue", sender: self)
    }
    @IBAction func signUpButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    
    func handleLogin(){
        
        if((self.emailTxtField.text?.characters.count)! < 6 || (self.passwordTextField.text?.characters.count)! < 3 ){
            
            self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incompleteCredentials.rawValue, titleButton: AlertTitleForButtons.incompleteCredentials.rawValue)
            
        }else{
            
            let user: User = User(
                name: "",
                email: self.emailTxtField.text!,
                password: self.passwordTextField.text!
            )
        
            user.signIn()
            let loginResultNotification = Notification.Name(rawValue:"loginResultNotification")
            let nc = NotificationCenter.default
            nc.addObserver(forName:loginResultNotification, object:nil, queue:nil, using:handleNotificationResponse)
        }
    }
    
    func handleNotificationResponse(notification:Notification) -> Void{
        
        guard let userInfo = notification.userInfo,
            let success  = userInfo["success"] as? Bool else {
                print("No userInfo found in notification")
                return
        }
        
        if(success){
            self.performSegue(withIdentifier: "fromSignToHomeSegue", sender: self)
            
        }else{
            self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incorrectCredentials.rawValue, titleButton: AlertTitleForButtons.incorrectCredentials.rawValue)
        }
    }
    
    
    func buildAlert(titleController: String,
                    messageController: String,
                    titleButton: String){
        let alert = UIAlertController(title: titleController, message: messageController, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleButton, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory(uiView: UIView) {
        
        let actInd: NVActivityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: 70, height: 70),
            type: .ballTrianglePath,
            color: UIColor.purple,
            padding: CGFloat(0))
        
        actInd.center = uiView.center
        uiView.addSubview(actInd)
        actInd.startAnimating()
        
    }
    

}

