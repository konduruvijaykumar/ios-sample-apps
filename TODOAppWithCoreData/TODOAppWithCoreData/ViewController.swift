//
//  ViewController.swift
//  TODOAppWithCoreData
//
//  Created by Vijay Konduru on 04/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// https://www.youtube.com/watch?v=qt8BNhpEAok
// https://www.youtube.com/watch?v=peSXZi_nxek
// https://www.raywenderlich.com/20881/beginning-auto-layout-part-1-of-2

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoListTableView: UITableView!;
    var todos: [Todo] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todoListTableView.dataSource = self;
        todoListTableView.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get data from core data
        getTodoData();
        
        // Update table view
        todoListTableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        let todo = todos[indexPath.row];
        //print("Entity object unique objectID is \(todo.objectID)");
        if(todo.isImportant){
            cell.textLabel?.text = "❗️ \(todo.itemData!)";
        }else{
            cell.textLabel?.text = todo.itemData!;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let _appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let _appContext = _appDelegate.persistentContainer.viewContext;
        
        if(editingStyle == .delete){
            let todo = todos[indexPath.row];
            _appContext.delete(todo);
            _appDelegate.saveContext();
            
            do{
                todos = try _appContext.fetch(Todo.fetchRequest());
            }catch{
                print("Something Is Wrong");
            }
        }
        todoListTableView.reloadData();
    }
    
    func getTodoData(){
        let _appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let _appContext = _appDelegate.persistentContainer.viewContext;
        do{
            todos = try _appContext.fetch(Todo.fetchRequest());
        }catch{
            print("Something Is Wrong");
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateSegue", sender: todos[indexPath.row]);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // http://stackoverflow.com/questions/34004252/how-to-segue-to-a-specific-view-controller-depending-on-the-segue-identity-from
        if(segue.identifier == "updateSegue"){
            // Need this logic only for update segue and else will have no logic. So others will not go through this logic
            let referenceGuest = segue.destination as! UpdateTaskViewController;
            referenceGuest.todo = sender as? Todo;
        }
    }

}

