//
//  UpdateTaskViewController.swift
//  TODOAppWithCoreData
//
//  Created by Vijay Konduru on 05/02/17.
//  Copyright © 2017 CSC. All rights reserved.
//

// http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
// http://stackoverflow.com/questions/16050516/how-to-connect-multiple-buttons-in-a-storyboard-to-a-single-action

import UIKit

class UpdateTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var isImpSwitch: UISwitch!
    
    var todo: Todo?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        todoTextField.delegate = self;
        todoTextField.text = todo?.itemData;
        isImpSwitch.isOn = (todo?.isImportant)!;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Not a good way to do, but xcode is unable to map to existing function "updateTodoItem". Hence create an action for this and called existing function "updateTodoItem"
    @IBAction func callUpdateTodoItem(_ sender: Any) {
        updateTodoItem(sender);
    }
    
    @IBAction func updateTodoItem(_ sender: Any) {
        if(todo != nil){
            if(todoTextField.text != nil && todoTextField.text != ""){
                // https://code.tutsplus.com/tutorials/core-data-and-swift-managed-objects-and-fetch-requests--cms-25068
                let _appDelegate = UIApplication.shared.delegate as! AppDelegate;
                // Commenting it as we dont use it
                //let _appContext = _appDelegate.persistentContainer.viewContext;
                //let todo = Todo(context: _appContext);
                // Commenting the below code works on updating existing instance and not create new record. todo record is already retreived from core data should have appcontext initialized.
                //todo = Todo(context: _appContext);
                // http://stackoverflow.com/questions/26799298/ios-core-data-set-attribute-primary-key
                // http://stackoverflow.com/questions/901640/core-data-primary-key
                //print("Entity object unique objectID is \(todo!.objectID)");
                todo!.itemData = todoTextField.text!;
                todo!.isImportant = isImpSwitch.isOn;
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return true;
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
