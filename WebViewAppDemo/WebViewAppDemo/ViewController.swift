//
//  ViewController.swift
//  WebViewAppDemo
//
//  Created by Vijay Konduru on 07/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// http://www.alphansotech.com/blogs/how-to-use-web-view-in-ios-using-swift/
// https://www.youtube.com/watch?v=UFKBTiylaN4
// http://rshankar.com/swift-webview-demo/
// http://stackoverflow.com/questions/39682344/swift-3-webview

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebsiteView: UIWebView!
    
    @IBOutlet weak var myWebsiteNavigationItem: UINavigationItem!
    
    @IBAction func backBarButtonClicked(_ sender: Any) {
        if(myWebsiteView.canGoBack){
            myWebsiteView.goBack();
        }
    }
    
    @IBAction func forwardBarButtonClicked(_ sender: Any) {
        if(myWebsiteView.canGoForward){
            myWebsiteView.goForward();
        }
    }
    
    @IBAction func stopBarButtonClicked(_ sender: Any) {
        myWebsiteView.stopLoading();
    }
    
    @IBAction func refreshBarButtonClicked(_ sender: Any) {
        myWebsiteView.reload();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //myWebsiteView.loadRequest(URLRequest(url: URL(string: "http://www.apple.com/")!));
        // WebViewAppDemo[11848:204385] App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.
        // To solve this problem add NSAppTransportSecurity(App Transport Security Settings) in info.plist this a dictionary. Under that add NSAllowsArbitraryLoads(Allow Arbitrary Loads) with Boolean values as YES
        //myWebsiteView.loadRequest(URLRequest(url: URL(string: "http://www.gsmarena.com/")!));
        
        //myWebsiteNavigationItem.title = "Apple";
        myWebsiteView.loadRequest(URLRequest(url: URL(string: "http://www.apple.com/")!));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

