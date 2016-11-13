//
//  SignUpViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    
    enum AlertControllerTitles: String{
        case incorretCredentials = "Oops"
    }
    
    enum AlertControllerMessages: String {
        case incorrectCredentials = "Senha ou Email incorretos majestade"
        case incompleteCredentials = "Tem coisa faltando no email, nome, ou senha"
    }
    
    enum AlertTitleForButtons: String {
        case incorrectCredentials = "Ok, vou tentar de novo"
        case incompleteCredentials = "Ok, vou arrumar"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func createAccountButton(_ sender: AnyObject) {
        if(self.validateFields()){
            
            let user: User = User(
                name: self.nameTxtField.text!,
                email: self.emailTxtField.text!,
                password: self.passwordTxtField.text!)
            
            user.signUp()
            self.showActivityIndicatory(uiView: self.view)
            let signUpResultNotification = Notification.Name(rawValue:"signUpResultNotification")
            let nc = NotificationCenter.default
            nc.addObserver(forName:signUpResultNotification, object:nil, queue:nil, using:handleNotificationResponse)
            
        }else{
            self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incompleteCredentials.rawValue, titleButton: AlertTitleForButtons.incompleteCredentials.rawValue)
        }
        
    }
    
    @IBAction func goBackToSignPageButton(_ sender: AnyObject) {
        
    }
    
    func validateFields() -> Bool{
        
        if( (self.nameTxtField.text?.characters.count)! > 3 &&
            (self.emailTxtField.text?.characters.count)! >= 6 &&
            (self.passwordTxtField.text?.characters.count)! >= 4){
            return true
        }
        return false
    }
    
    func handleNotificationResponse(notification:Notification) -> Void{
        
        guard let userInfo = notification.userInfo,
            let success  = userInfo["success"] as? Bool else {
                print("Problems during the sign up process")
                return
        }
        
        if(success){
            self.performSegue(withIdentifier: "signupToHomeSegue", sender: self)
            
        }else{
            self.buildAlert(titleController: AlertControllerTitles.incorretCredentials.rawValue, messageController: AlertControllerMessages.incompleteCredentials.rawValue, titleButton: AlertTitleForButtons.incompleteCredentials.rawValue)
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
