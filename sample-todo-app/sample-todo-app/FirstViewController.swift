//
//  FirstViewController.swift
//  sample-todo-app
//
//  Created by Vijay Konduru on 03/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// https://www.youtube.com/watch?v=LrCqXmHenJY

import UIKit

// Making it a global variable
var todoList = ["Run Every Day Morning","Buy Groceries","Refill Tea Powder","Water plants","Call Peter","Some todo with longer text to check if wrap works for the data it has"];

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todoList.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "todocell");
        cell.textLabel?.text = todoList[indexPath.row];
        return cell;
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCellEditingStyle.delete){
            todoList.remove(at: indexPath.row);
            todoListTableView.reloadData();
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        todoTableView.reloadData();
    }

    @IBOutlet weak var todoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

