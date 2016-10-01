//
//  ResquestHandler.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation

class ResquestHandler {
    
    var method, params, route: String?
    var user: User
    
    init(method: String, params: String, route: String, user: User){
        self.method = method
        self.params = params
        self.route = route
        self.user = user
    }
    
    func createRequest() -> [String: String]{
        
        return ["ok" : "nok"]
    }
    
    
    
    
    
}
