//
//  NewTodoViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/13/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit

class NewTodoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var todoTitleTxtField: UITextField!
    
    @IBOutlet weak var todoDescriptionField: UITextField!
    
    @IBOutlet weak var todoDueDatePicker: UIDatePicker!
    
    @IBOutlet weak var todoLevelPicker: UIPickerView!
    
    @IBOutlet weak var todoPriorityPicker: UIPickerView!
    
    
    let level = ["Molezinha", "Okaay", "Hard" , "Zeus"]
    
    let priority = ["De buenas", "Normale" , "Sério", "Pra ontem"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.todoLevelPicker.dataSource = self
        self.todoLevelPicker.delegate = self
        
        self.todoPriorityPicker.dataSource = self
        self.todoPriorityPicker.delegate = self
        
        self.todoDueDatePicker.minimumDate = Date()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.todoLevelPicker:
            return level[row]
        case self.todoPriorityPicker:
            return priority[row]
        default:
            return "None"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.todoLevelPicker:
            return level.count
        case self.todoPriorityPicker:
            return priority.count
        default:
            return 1
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    @IBAction func createTodoButton(_ sender: AnyObject) {
        if(validateInputs()){
        let todo: Todo = Todo(
            id: "",
            title: self.todoTitleTxtField.text!,
            description: self.todoDescriptionField.text!,
            level: level[self.todoLevelPicker.selectedRow(inComponent: 0)],
            priority: priority[self.todoPriorityPicker.selectedRow(inComponent: 0)],
            dueDate: self.todoDueDatePicker.date,
            finishedAt: Date(),
            done: false)
        
        todo.createTodo()
        }
        else{
            let alert = UIAlertController(title: "Opa", message: "Eai queridona ou queridão, coloca ao menos um título ;)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, vou colocar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func validateInputs() -> Bool {
        
        if((self.todoTitleTxtField.text?.characters.count)! >= 3){
            return true
        }
        
        return false
    }
    
    
    
    
}
