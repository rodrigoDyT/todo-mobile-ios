//
//  NewTodoViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/13/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit

class NewTodoViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTxtField: UITextField!
    
    @IBOutlet weak var todoDescriptionField: UITextField!
    
    @IBOutlet weak var todoDueDatePicker: UIDatePicker!
    
    @IBOutlet weak var todoLevelPicker: UIPickerView!
    
    @IBOutlet weak var todoPriorityPicker: UIPickerView!
    
    
    /*
    let pickerData = [
        ["10\"","14\"","18\"","24\""],
        ["Cheese","Pepperoni","Sausage","Veggie","BBQ Chicken"]
    ]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func createTodoButton(_ sender: AnyObject) {
        let todo: Todo = Todo(
            id: "",
            title: "Testing out Swift",
            description: "The one for the project",
            level: "Easy but requires work",
            priority: "High",
            dueDate: Date().addingTimeInterval(3),
            finishedAt: Date(),
            done: false)
        
        todo.createTodo()
        
    }
    
    
    
}
