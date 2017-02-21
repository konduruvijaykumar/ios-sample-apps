//
//  ViewController.swift
//  SliderMenuDemo
//
//  Created by Vijay Konduru on 17/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// We can try cocoapods for below library, trying to understand the other of adding library and briding objective-C aith Swift
//https://cocoapods.org/pods/SWRevealViewController
//https://github.com/John-Lluch/SWRevealViewController
//https://www.youtube.com/watch?v=xp6zpHACVbI
//http://stackoverflow.com/questions/24002369/how-to-call-objective-c-code-from-swift
//https://www.youtube.com/watch?v=OvDk5zXCFe8
//https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/
//https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html#//apple_ref/doc/uid/TP40014216-CH10-ID122
//https://developer.apple.com/library/content/navigation/
//https://developer.apple.com/videos/

import UIKit

class JavaViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Burger menu actions
        if (revealViewController() != nil) {
            menuButton.target = revealViewController();
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:));
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

