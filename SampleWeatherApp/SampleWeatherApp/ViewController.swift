//
//  ViewController.swift
//  SampleWeatherApp
//
//  Created by Vijay Konduru on 22/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

//https://www.youtube.com/watch?v=YLAsBxGpcMQ
//http://stackoverflow.com/questions/28499701/how-can-i-change-the-uisearchbar-search-text-color
//http://stackoverflow.com/questions/19048766/uisearchbar-text-color-change-in-ios-7
//http://stackoverflow.com/questions/32505544/how-to-include-emoticons-in-swift-string

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!;
    @IBOutlet weak var cityLbl: UILabel!;
    @IBOutlet weak var conditionLbl: UILabel!;
    @IBOutlet weak var temperatureLbl: UILabel!;
    @IBOutlet weak var weatherImageView: UIImageView!;
    
    var city: String!;
    var condition: String!;
    var imageURL: String!;
    var temperature: Int!;
    
    var dataExists: Bool = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Signup for a free api key from https://www.apixu.com/ and replace YOUR_API_KEY with you key
        let apiEndPoint: String = "http://api.apixu.com/v1/current.json?key=YOUR_API_KEY&q=\(searchBar.text!)";
        let formattedUrl: String = apiEndPoint.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!;
        
        let urlRequest = URLRequest(url: URL(string: formattedUrl)!);
        
        // Hiding keyboard
        searchBar.resignFirstResponder();
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        
                        if let temp = current["temp_c"] as? Int {
                            self.temperature = temp;
                        }
                        if let condition = current["condition"] as? [String : AnyObject] {
                            self.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imageURL = "http:\(icon)"
                        }
                    }
                    if let location = json["location"] as? [String : AnyObject] {
                        self.city = location["name"] as! String
                    }
                    
                    if let _ = json["error"] {
                        self.dataExists = false
                    }
                    
                    DispatchQueue.main.async {
                        if(self.dataExists){
                            self.temperatureLbl.isHidden = false
                            self.conditionLbl.isHidden = false
                            self.weatherImageView.isHidden = false
                            self.temperatureLbl.text = "\(self.temperature.description)°"
                            self.cityLbl.text = self.city
                            self.conditionLbl.text = self.condition
                            self.weatherImageView.downloadImage(from: self.imageURL!)
                        }else {
                            self.temperatureLbl.isHidden = true
                            self.conditionLbl.isHidden = true
                            self.weatherImageView.isHidden = true
                            self.cityLbl.text = "No matching city found"
                            self.dataExists = true
                        }
                    }
                    
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder();
    }
    
    // Not working as desired, keyboard not getting hidden
    /**
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
     //self.view.endEditing(true);
     //searchBar.endEditing(true);
     searchBar.resignFirstResponder();
     }
     */


}


extension UIImageView {
    
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
    
}
