//
//  HomeViewController.swift
//  PowerTodo
//
//  Created by Rodrigo on 9/27/16.
//  Copyright © 2016 SG Solutions. All rights reserved.
//

import Foundation
import UIKit


class HomeViewController : UIViewController {
    
    @IBOutlet weak var todosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newTodoButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "newTodoSegue", sender: self)
    }
   
    
    
}
