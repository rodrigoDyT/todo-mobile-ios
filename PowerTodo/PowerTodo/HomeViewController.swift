//
//  HomeViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/27/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit
import SwipyCell
import NVActivityIndicatorView

class HomeViewController : UIViewController,UITableViewDelegate, UITableViewDataSource, SwipyCellDelegate{
    
    @IBOutlet weak var todosTableView: UITableView!
    var actInd: NVActivityIndicatorView! = nil
    
    var userTodos: [[String: AnyObject]]!
    
    enum ActionOnTodos {
        case setDone
        case destroy
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTodos()
        let waitForTodos = Notification.Name(rawValue:"waitForTodos")
        let nc = NotificationCenter.default
        nc.addObserver(forName:waitForTodos, object:nil, queue:nil, using:handleNotificationResponse)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicatory(uiView: self.view)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.purple
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "PowerTodo"
        
        
        let rightButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "shut_down"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if(self.userTodos == nil){
            self.todosTableView.isHidden = true
        }
        
    }
    
    func logout(){
        self.performSegue(withIdentifier: "fromHomeToSignInSegue", sender: self)
    }
    
    func handleNotificationResponse(notification: Notification){
        self.actInd.stopAnimating()
        guard let userInfo = notification.userInfo,
            let success  = userInfo["success"] as? Bool else {
                print("No userInfo found in notification")
                return
        }
        
        if(success){
            guard let todoList = userInfo["todoList"] as? [[String : AnyObject]] else {
                print("Something went wrong")
                return
            }
            self.userTodos = todoList
            self.todosTableView.reloadData()
            self.todosTableView.isHidden = false
            
        }else{
            let alert = UIAlertController(title: "Oops", message: "Eai queridona ou queridão, não achei nenhum Todo, tenta de novo ou cria alguns ;)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, vou tentar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getTodos(){
        let todo: Todo = Todo(id: "",
                              title: "",
                              description: "",
                              level: "",
                              priority: "",
                              dueDate: Date(),
                              finishedAt: Date(),
                              done: false)
        todo.getAllTodos()
        
    }
    
    @IBAction func newTodoButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "newTodoSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.userTodos != nil){
            return self.userTodos.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.userTodos != nil){
            let userTodo: [String: AnyObject] = self.userTodos[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TableCellTodoCustomize
            cell.todoDescriptionLabel.text = userTodo["description"] as? String
            cell.todoTitleLabel.text = userTodo["title"] as? String
            cell.todoLevelLabel.text = userTodo["level"] as? String
            
            cell.todoDueDateLabel.text = userTodo["dueDate"] as? String
         
            let priority: String = (userTodo["priority"] as? String)!
            switch priority {
            case "Pra ontem":
                cell.todoPriority.image = UIImage(named: "priorityPraOntem")
                break
            case "Sério":
                cell.todoPriority.image = UIImage(named: "prioritySerio")
                break
            case "Normale":
                cell.todoPriority.image = UIImage(named: "priorityNormale")
                break
            default:
                cell.todoPriority.image = UIImage(named: "priorityDeBuenas")
            }
            
            return cell
            
        }else{
            let cell = SwipyCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = "Nenhum todo encontrado queridona ou queridão"
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            print ("About to delete row")
            
        }
    }

    // When the user starts swiping the cell this method is called
    func swipeableTableViewCellDidStartSwiping(_ cell: SwipyCell) {}
    
    // When the user ends swiping the cell this method is called
    func swipeableTableViewCellDidEndSwiping(_ cell: SwipyCell) {}
    
    // When the user is dragging, this method is called with the percentage from the border
    func swipeableTableViewCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Apagar") { (action, indexPath) in
            // delete item at indexPath
            let ind: IndexPath = (indexPath as IndexPath)
            self.updateTodoBasedOnSwipe(action: ActionOnTodos.destroy, indexPath: ind)
        }
        
        let done = UITableViewRowAction(style: .normal, title: "Terminei") { (action, indexPath) in
            // share item at indexPath
            let ind: IndexPath = (indexPath as IndexPath)
            self.updateTodoBasedOnSwipe(action: ActionOnTodos.setDone, indexPath: ind)
        }
        
        done.backgroundColor = UIColor.blue
        
        return [delete, done]
    }
    
    
    func updateTodoBasedOnSwipe(action: ActionOnTodos, indexPath: IndexPath) {
        switch action {
        case .setDone:
            print("setting done")
        case .destroy:
            print("destroying todo")
        }
        
        self.userTodos.remove(at: indexPath.row)
        self.todosTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.todosTableView.reloadData()
        
    }
    
    
    func viewWithImageName(_ imageName: String) -> UIView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        return imageView
    }
    
    @IBAction func unwindHomeViewTodos(_ segue: UIStoryboardSegue) {
        self.getTodos()
        self.todosTableView.reloadData()
        
        if !segue.source.isBeingDismissed {
            segue.source.dismiss(animated: true, completion: nil) ;
        }
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
