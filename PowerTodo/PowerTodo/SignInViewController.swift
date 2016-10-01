//
//  ViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/20/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtn(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "fromSignToHomeSegue", sender: self)
        
    }

    @IBAction func signUpBtn(_ sender: AnyObject) {
        let user: User  = User(name: "John Smith", email: "johnny@emailg.com", password: "123abc", token: nil)
        user.signUp()
        
        
        //self.performSegue(withIdentifier: "signUpSegue", sender: self)
        
    }
}

