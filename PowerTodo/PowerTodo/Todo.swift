//
//  Todo.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/13/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import Alamofire

class Todo {
    enum Methods {
        case createTodo
        case getAllTodos
    }
    
    var id,title, description, level, priority: String!
    var dueDate, finishedAt: Date!
    var done: Bool
    
    init(id : String,
         title: String,
         description: String,
         level: String,
         priority: String,
         dueDate: Date,
         finishedAt: Date,
         done: Bool){
        self.id = id
        self.title = title
        self.description = description
        self.level = level
        self.priority = priority
        self.dueDate = dueDate
        self.finishedAt = finishedAt
        self.done = done
    }
    
    func createTodo(){
        self.performRequest(method: Methods.createTodo)
    }
    
    func getAllTodos(){
        self.performRequest(method: Methods.getAllTodos)
    }
    
    func performRequest(method: Methods) {
        
        let user: User =  User(name: "", email: "", password: "")
        
        
        let parameters: Parameters = [
            "id" : self.id,
            "title" : self.title,
            "description" : self.description,
            "level" : self.level,
            "priority" : self.priority,
            "dueDate" : self.dueDate,
            "finished_at" : self.finishedAt,
            "done" : self.done,
            "token" : user.getUserTokenDefault()]
        
        let urlRequest: TodoRouter!
        switch method {
            case .createTodo:
                urlRequest = TodoRouter.createTodo(parameters: parameters)
            case .getAllTodos:
                urlRequest = TodoRouter.getAllTodos(parameters: parameters)
        }
        
        Alamofire.request(urlRequest).responseJSON {
            response in
            
            // First make sure you got back a dictionary, if that's what you expect
            guard let todoReturn = response.result.value as? [AnyObject] else {
                print("Failed to get expected response from webserver.")
                self.handleTodoResponse(success: false, todoReturn: [])
                return
            }
            
            self.handleTodoResponse(success: true, todoReturn: todoReturn)
        }
    }
    
    func handleTodoResponse(success: Bool, todoReturn: [AnyObject]){
        
        let todoResponse = Notification.Name(rawValue:"waitForTodos")
        let nc = NotificationCenter.default
        nc.post(name:todoResponse,
                object: nil,
            userInfo:["success":success, "todoList" : todoReturn])
    }
    
    
    
}
