//
//  ViewController.swift
//  sample-rest-call
//
//  Created by Vijay Konduru on 01/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// Check Udacity Swift or iOS networking course

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var getIPButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This makes the GET call to httpbin.org. It simply gets the IP address and displays it on the screen.
    @IBAction func getIPAddress(_ sender: UIButton) {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "https://httpbin.org/ip")!
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if(error != nil) {
                //print(error!.localizedDescription);
                print("error = \(error)");
            } else {
                // Read the JSON
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary;
                    if let parseJSON = json {
                        let origin = parseJSON["origin"] as! String;
                        //self.ipAddressLabel.text = origin;
                        DispatchQueue.main.async {
                            self.ipAddressLabel.text = origin;
                        }
                    }
                } catch {
                    print("Something Wrong Happened")
                }
            }
        });
        task.resume();
    }

}

