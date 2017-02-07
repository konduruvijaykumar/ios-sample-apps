//
//  SecondViewController.swift
//  sample-todo-app
//
//  Created by Vijay Konduru on 03/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// http://stackoverflow.com/questions/24180954/how-to-hide-keyboard-in-swift-on-pressing-return-key
// http://stackoverflow.com/questions/24908966/hide-keyboard-for-text-field-in-swift-programming-language

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var todoItemData: UITextField!
    
    @IBAction func addTodoItem(_ sender: Any) {
        if(todoItemData.text != nil && todoItemData.text != ""){
            todoList.append(todoItemData.text!);
            todoItemData.text = "";
            self.todoItemData.resignFirstResponder();
        }
    }
    
    /**
    func hideKeyboardWhenTappedAround(){
        let uiTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard));
        //let uiTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.dismissKeyBoard));
        view.addGestureRecognizer(uiTap);
    }
    
    func dismissKeyBoard(){
        todoItemData.resignFirstResponder();
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todoItemData.delegate = self;
        //self.hideKeyboardWhenTappedAround();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.todoItemData.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //todoItemData.resignFirstResponder();
        self.view.endEditing(true);
        return true;
    }

}
