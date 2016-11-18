//
//  NewTodoViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 11/13/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class NewTodoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var todoTitleTxtField: UITextField!
    
    @IBOutlet weak var todoDescriptionField: UITextField!
    
    @IBOutlet weak var todoDueDatePicker: UIDatePicker!
    
    @IBOutlet weak var todoLevelPicker: UIPickerView!
    
    @IBOutlet weak var todoPriorityPicker: UIPickerView!
    
    var actInd: NVActivityIndicatorView! = nil
    
    let level = ["Molezinha", "Okaay", "Hard" , "Zeus"]
    
    let priority = ["De buenas", "Normale" , "Sério", "Pra ontem"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "PowerTodo"
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
            
            self.showActivityIndicatory(uiView: self.view)
            let todoResponse = Notification.Name(rawValue:"waitForTodos")
            let nc = NotificationCenter.default
            nc.addObserver(forName:todoResponse, object:nil, queue:nil, using:handleNotificationResponse)
            todo.createTodo()
            
        }
        else{
            let alert = UIAlertController(title: "Opa", message: "Eai queridona ou queridão, coloca ao menos um título ;)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, vou colocar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func handleNotificationResponse(notification: Notification) -> Void{
        
        self.actInd.stopAnimating()
        
        guard let userInfo = notification.userInfo,
            let success  = userInfo["success"] as? Bool else {
                print("No userInfo found in notification")
                return
        }
        
        if(success){
            let alert = UIAlertController(title: "Ai Sim", message: "Manda ver nesse! Pois Todo criado com sucesso", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, show!", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                self.performSegue(withIdentifier: "fromNewTodoToHomeSegue", sender: self)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Opa", message: "Eai queridona ou queridão, não deu para criar o Todo, tenta mais uma vez?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, vou tentar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func goBackToHomeViewButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "fromNewTodoToHomeSegue", sender: self)
    }
    
    
    func validateInputs() -> Bool {
        
        if((self.todoTitleTxtField.text?.characters.count)! >= 3){
            return true
        }
        
        return false
    }
    
    func showActivityIndicatory(uiView: UIView) {
        
        self.actInd = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: 70, height: 70),
            type: .ballGridPulse,
            color: UIColor.purple,
            padding: CGFloat(0))
        
        actInd.center = uiView.center
        uiView.addSubview(actInd)
        actInd.startAnimating()
        
    }
    
    
    
    
}
