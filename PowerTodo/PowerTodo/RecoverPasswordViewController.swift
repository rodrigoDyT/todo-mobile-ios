//
//  RecoverPasswordViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/14/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit

class RecoverPasswordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackToSignInButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "fromRecoverPasswordToSignInSegue", sender: self)
    }
    
}
