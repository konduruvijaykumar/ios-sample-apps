//
//  AddTaskViewController.swift
//  TODOAppWithCoreData
//
//  Created by Vijay Konduru on 04/02/17.
//  Copyright © 2017 CSC. All rights reserved.
//

// http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
// http://stackoverflow.com/questions/16050516/how-to-connect-multiple-buttons-in-a-storyboard-to-a-single-action

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var isImpSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoTextField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Not a good way to do, but xcode is unable to map to existing function "addTodoItem". Hence create an action for this and called existing function "addTodoItem"
    @IBAction func callAddTodoItem(_ sender: Any) {
        addTodoItem(sender);
    }
    
    @IBAction func addTodoItem(_ sender: Any) {
        if(todoTextField.text != nil && todoTextField.text != ""){
            let _appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let _appContext = _appDelegate.persistentContainer.viewContext;
            let todo = Todo(context: _appContext);
            todo.itemData = todoTextField.text!;
            todo.isImportant = isImpSwitch.isOn;
            todoTextField.resignFirstResponder();
            _appDelegate.saveContext();
            navigationController!.popViewController(animated: true);
        }else{
            // Create alert controller object
            let alert = UIAlertController(title: "Todo Item", message: "Please enter valid Todo Item", preferredStyle: UIAlertControllerStyle.alert);
            // Add action to alert controller
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            // Show Alert window
            self.present(alert, animated: true, completion: nil);
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return true;
    }

}
