//
//  ViewController.swift
//  lable-update-onclick-button
//
//  Created by Vijay Konduru on 30/01/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
// http://stackoverflow.com/questions/24180954/how-to-hide-keyboard-in-swift-on-pressing-return-key
// http://www.snip2code.com/Snippet/85930/swift-delegate-sample
// http://stackoverflow.com/questions/37229132/swift-how-to-resign-first-responder-on-all-uitexfield
// http://stackoverflow.com/questions/24034786/resignfirstresponder-in-swift

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var helloWorldText: UILabel!
    @IBOutlet var customTextField: UITextField!
    @IBOutlet var changeTextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.customTextField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeTextOnClick(_ sender: UIButton) {
        let customText = self.customTextField.text;
        self.helloWorldText.text = customText;
        self.customTextField.resignFirstResponder();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.customTextField.resignFirstResponder();
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }

}

