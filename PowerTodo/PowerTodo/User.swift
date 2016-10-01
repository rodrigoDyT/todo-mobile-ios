//
//  User.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import Alamofire

class User {
    
    var name, email,password, token: String!
    init(name: String, email: String,password: String, token: String?){
        self.name = name
        self.email = email
        self.password = password
        self.token = token ?? ""
    }
    
    func signUp() {
        let parameters: Parameters = [
            "name" : self.name,
            "email" : self.email,
            "password" : self.password]
        
        Alamofire.request(UserRouter.createUser(parameters: parameters)).responseJSON {
            response in
            
            // First make sure you got back a dictionary if that's what you expect
            guard let json = response.result.value as? [String : AnyObject] else {
                print("Failed to get expected response from webserver.")
                return
            }
            
            // Then make sure you get the actual key/value types you expect
            guard let userToken = json["token"] as? String else {
                print("Failed to get data from webserver")
                return
            }
            self.token = userToken
            print(self.token)
        }
        
    }
    
    func signIn(){
        
    }
    
    
    
}
