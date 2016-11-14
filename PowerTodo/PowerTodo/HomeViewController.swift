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

class HomeViewController : UIViewController,UITableViewDelegate, UITableViewDataSource, SwipyCellDelegate{
    
    @IBOutlet weak var todosTableView: UITableView!
    
    var userTodos: [[String: AnyObject]]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTodos()
        let waitForTodos = Notification.Name(rawValue:"waitForTodos")
        let nc = NotificationCenter.default
        nc.addObserver(forName:waitForTodos, object:nil, queue:nil, using:handleNotificationResponse)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let alert = UIAlertController(title: "Oops", message: "Eai queridona ou queridão, não achei nenhum Todo, tenta de novo", preferredStyle: UIAlertControllerStyle.alert)
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
            
            let cell = SwipyCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell.selectionStyle = .gray
            cell.contentView.backgroundColor = UIColor.white
            cell.textLabel?.font = UIFont(name: "Helvetica Neue Condensed Bold", size: 17)
            cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 15)
            
            cell.textLabel?.textColor = UIColor.purple
            cell.detailTextLabel?.textColor = UIColor.purple
            
            cell.detailTextLabel?.textAlignment = .right
            
            let doneView = viewWithImageName("done")
            let greenColor = UIColor(red: 85.0 / 255.0, green: 213.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
            
            let deleteView = viewWithImageName("close")
            let redColor = UIColor(red: 232.0 / 255.0, green: 61.0 / 255.0, blue: 14.0 / 255.0, alpha: 1.0)
            
            
            cell.defaultColor = tableView.backgroundView?.backgroundColor
            cell.delegate = self
            
            cell.textLabel?.text = userTodo["title"] as? String
            cell.detailTextLabel?.text = userTodo["description"] as? String
            
            cell.setSwipeGesture(doneView, color: greenColor, mode: .switch, state: .state1, completionHandler: { (cell: SwipyCell, state: SwipyCellState, mode: SwipyCellMode) in
                print("Did swipe \"Checkmark\" cell")
            })
            
            cell.setSwipeGesture(deleteView, color: redColor, mode: .switch, state: .state3, completionHandler: { (cell: SwipyCell, state: SwipyCellState, mode: SwipyCellMode) in
                print("Did swipe \"Cross\" cell")
            })
            
            return cell
            
        }else{
            let cell = SwipyCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = "No data loaded"
            return cell
        }
    }

    // When the user starts swiping the cell this method is called
    func swipeableTableViewCellDidStartSwiping(_ cell: SwipyCell) {}
    
    // When the user ends swiping the cell this method is called
    func swipeableTableViewCellDidEndSwiping(_ cell: SwipyCell) {}
    
    // When the user is dragging, this method is called with the percentage from the border
    func swipeableTableViewCell(_ cell: SwipyCell, didSwipeWithPercentage percentage: CGFloat) {
        print(percentage)
    }
    
    
    func viewWithImageName(_ imageName: String) -> UIView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        return imageView
    }
    
}
