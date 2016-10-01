//
//  UserRouter.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/28/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//  Exemplo usado: Alamofire github Router

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
    case createUser(parameters: Parameters)
    case getUserToken(parameters: Parameters)
    //case updateUser(username: String, parameters: Parameters)
    //case destroyUser(username: String)
    
    static let baseURLString = "https://api-rodrigo-todo.herokuapp.com/api"
    
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .getUserToken:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/createuser"
        case .getUserToken:
            return "/gettoken"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try UserRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createUser(let parameters),  .getUserToken(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
