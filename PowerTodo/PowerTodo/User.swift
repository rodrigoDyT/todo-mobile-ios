//
//  User.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.

import Foundation
import Alamofire

class User {
    
    enum Methods {
        case createUser
        case getToken
    }
    
    var name, email,password: String!
    init(name: String, email: String,password: String){
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signUp(){
        self.performRequest(method: Methods.createUser)
    }
    
    func signIn(){
        self.performRequest(method: Methods.getToken)
    }
    
    func performRequest(method: Methods) {
        let parameters: Parameters = [
            "name" : self.name,
            "email" : self.email,
            "password" : self.password]
        
        let urlRequest: UserRouter!
        switch method {
        case .createUser:
            urlRequest = UserRouter.createUser(parameters: parameters)
        case .getToken:
            urlRequest = UserRouter.getUserToken(parameters: parameters)
        }
        
        Alamofire.request(urlRequest).responseJSON {
            response in
            
            // First make sure you got back a dictionary, if that's what you expect
            guard let json = response.result.value as? [String : AnyObject] else {
                print("Failed to get expected response from webserver.")
                return
            }
            print(json)
            // Then make sure you get the actual key/value types you expect
            guard let userToken = json["token"] as? String else {
                print("Failed to get data from webserver")
                return
            }
            self.setUserTokenDefault(token: userToken)
            
        }
        
    }
    
    
    func setUserTokenDefault(token: String){
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "powerTodoToken")
        defaults.synchronize()
    }
    
    func getUserTokenDefault() -> String{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "powerTodoToken") as! String? ?? ""
    }
    
    
    
}
