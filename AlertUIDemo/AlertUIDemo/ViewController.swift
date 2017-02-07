//
//  ViewController.swift
//  AlertUIDemo
//
//  Created by Vijay Konduru on 05/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
// http://stackoverflow.com/questions/911137/creating-iphone-pop-up-menu-similar-to-mail-app-menu
// https://www.youtube.com/watch?v=bgyR_IIYqLA

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func oneButtonAlert(_ sender: Any) {
        // Create alert controller object
        let alert = UIAlertController(title: "Alert Demo", message: "One button alert demo message", preferredStyle: UIAlertControllerStyle.alert);
        // Add action to alert controller
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
        // Show Alert window
        self.present(alert, animated: true, completion: nil);
    }

    @IBAction func twoButtonAlert(_ sender: Any) {
        // Create alert controller object
        let alert = UIAlertController(title: "Alert Demo", message: "Two button alert demo message", preferredStyle: UIAlertControllerStyle.alert);
        // Add action to alert controller
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {
            (action) in print("Continue Clicked");
            }));
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (action) in print("Cancel Clicked");
        }));
        // Show Alert window
        self.present(alert, animated: true, completion: nil);
    }
    
    @IBAction func threeButtonAlert(_ sender: Any) {
        // Create alert controller object
        let alert = UIAlertController(title: "Alert Demo", message: "Three button alert demo message, destructive style action will be in red", preferredStyle: UIAlertControllerStyle.alert);
        // Add action to alert controller
        alert.addAction(UIAlertAction(title: "Open File", style: UIAlertActionStyle.default, handler: {
            (action) in print("Open File Clicked");
        }));
        // UIAlertActionStyle.destructive shows colour in red, this used for data, media etc delete which cannot be reversed
        alert.addAction(UIAlertAction(title: "Destroy File", style: UIAlertActionStyle.destructive, handler: {
            (action) in print("Destroy File Clicked");
        }));
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (action) in print("Cancel Clicked");
        }));
        // Show Alert window
        self.present(alert, animated: true, completion: nil);
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        // Create alert controller object
        // let alert = UIAlertController(title: "Action Sheet Demo", message: "Action Sheet demo message, destructive style action will be in red", preferredStyle: UIAlertControllerStyle.alert);
        let alert = UIAlertController(title: "Action Sheet Demo", message: "Action Sheet demo message, destructive style action will be in red", preferredStyle: UIAlertControllerStyle.actionSheet);
        // Add action to alert controller
        alert.addAction(UIAlertAction(title: "Red", style: UIAlertActionStyle.default, handler: {
            (action) in print("Red Clicked");
        }));
        alert.addAction(UIAlertAction(title: "Yellow", style: UIAlertActionStyle.default, handler: {
            (action) in print("Yellow Clicked");
        }));
        alert.addAction(UIAlertAction(title: "Green", style: UIAlertActionStyle.default, handler: {
            (action) in print("Green Clicked");
        }));
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (action) in print("Cancel Clicked");
        }));
        // UIAlertActionStyle.destructive shows colour in red, this used for data, media etc delete which cannot be reversed
        //NOTE: to terminate app, do not use exit(0) because that is logged as a crash.
        // http://stackoverflow.com/questions/14335848/exit-application-when-click-button-ios
        // http://stackoverflow.com/questions/26511014/how-to-exit-app-and-return-to-home-screen-in-ios-8-using-swift-programming
        alert.addAction(UIAlertAction(title: "Kill App", style: UIAlertActionStyle.destructive, handler: {
            (action) in /**print("Kill App Clicked")exit(0)*/self.killApp(title: "Kill App");
        }));
        // Show Alert window
        self.present(alert, animated: true, completion: nil);
    }
    
    //NOTE: to terminate app, do not use exit(0) because that is logged as a crash.
    func killApp(title: String) -> Void {
        print("\(title) Clicked");
        exit(0);
    }
    
}

