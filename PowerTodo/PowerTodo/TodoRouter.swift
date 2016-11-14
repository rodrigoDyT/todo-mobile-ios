//
//  TodoRouter.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/13/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import Alamofire

enum TodoRouter: URLRequestConvertible {
    
    case createTodo(parameters: Parameters)
    case getAllTodos(parameters: Parameters)
    case finishTodo(parameters: Parameters)
    case deleteTodo(parameters: Parameters)
    
    
    static let baseURLString = "https://api-rodrigo-todo.herokuapp.com/api"
    
    var method: HTTPMethod {
        switch self {
        case .createTodo:
            return .post
        case .getAllTodos:
            return .get
        case .finishTodo:
            return .put
        case .deleteTodo:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .createTodo:
            return "/todos"
        case .getAllTodos:
            return "/todos"
        case .finishTodo(let todoId) , .deleteTodo(let todoId):
            return "/todos/\(todoId)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try UserRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createTodo(let parameters),  .getAllTodos(let parameters), .finishTodo(let parameters), .deleteTodo(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
