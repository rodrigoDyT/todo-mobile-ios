//
//  User.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation

class User {

    var name, email,password, token: String?
    init(name: String, email: String,password: String, token: String?){
        self.name = name
        self.email = email
        self.password = password
        self.token = token ?? ""
    }
    
    func signUp(){
        
    }
    
    func signIn(){
        
    }
    
    
    
}
