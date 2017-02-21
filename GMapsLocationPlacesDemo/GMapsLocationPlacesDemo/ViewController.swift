//
//  ViewController.swift
//  GMapsLocationPlacesDemo
//
//  Created by Vijay Konduru on 14/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

//https://developers.google.com/places/web-service/search
//https://developers.google.com/places/web-service/supported_types

//http://stackoverflow.com/questions/29398678/encoding-url-using-swift-code
//http://stackoverflow.com/questions/24879659/how-to-encode-a-url-in-swift
//http://stackoverflow.com/questions/24551816/swift-encode-url
//http://stackoverflow.com/questions/40939037/how-to-change-google-maps-marker-color-when-selected-in-swift

// This app did not work really well, in order keep track of possibilities tried out. I am leaving this as it is and making a proper attempt

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // IMP: atributes in json for nearby places
        // latitude: results -> geometry -> location -> lat
        // longitude: results -> geometry -> location -> lat
        // title: results -> name
        
        let camera = GMSCameraPosition.camera(withLatitude: 12.94982,longitude: 77.64302, zoom: 12);
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera);
        
        let marker = GMSMarker();
        marker.position = camera.target;
        marker.title = "Embassy Golf Links";// name in json
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = GMSMarker.markerImage(with: UIColor.cyan);
        marker.map = mapView;
        self.view = mapView;
        loadNearByPlaceMarkers(mapView: mapView);
    }
    
    
    func loadNearByPlaceMarkers(mapView: GMSMapView){
        
        let config = URLSessionConfiguration.default; // Session Configuration
        let session = URLSession(configuration: config); // Load configuration into Session
        let myUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=12.94982,77.64302&radius=3000&type=bank|atm&name=citi|icici|sbi|axis|hdfc&key=YOUR_SERVER_API_KEY";
        //let urlWithQueryParam = myUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
        let urlWithQueryParam = myUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
        //let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?")!
        //let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=12.94982,77.64302&radius=5000&type=bank|atm&name=citi|boa|chase&key=YOUR_SERVER_API_KEY")!;
        let url = URL(string: urlWithQueryParam!)!;
        
        //var request = URLRequest.init(url: url);
        //request.httpMethod = "GET";
        //request.addValue("12.94982,77.64302", forHTTPHeaderField: "location");
        //request.addValue("50000", forHTTPHeaderField: "radius");
        //request.addValue("bank|atm", forHTTPHeaderField: "type");
        //request.addValue("citi|boa|chase", forHTTPHeaderField: "name");
        //request.addValue("YOUR_SERVER_API_KEY", forHTTPHeaderField: "key");
        let task = session.dataTask(with: url, completionHandler:
            {
                (data, response, error) in
                
                // https://www.youtube.com/watch?v=LQ0he_I5_4g
                // http://stackoverflow.com/questions/30206983/gmsthreadexception-occur-when-displaying-gmsmarkers-on-ios-simulator
                if(error != nil) {
                    //print(error!.localizedDescription);
                    print("error = \(error)");
                }else{
                    // Read the JSON
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary;
                        if let mainJSON = json {
                            let resultsArray = mainJSON["results"] as? [AnyObject];
                            //print("\(resultsArray)!");
                            
                            for resultsJson in resultsArray!{
                                let name = resultsJson["name"] as! String;
                                //let icon = resultsJson["icon"] as! String;
                                //print(name,icon);
                                let geometry = resultsJson["geometry"] as AnyObject;
                                let location = geometry["location"] as AnyObject;
                                let lat = location["lat"] as! Double;
                                let lng = location["lng"] as! Double;
                                //print(name, "\t", icon, "\t", lat, "\t", lng);

                                DispatchQueue.main.async {
                                    let marker = GMSMarker();
                                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng);
                                    marker.appearAnimation = kGMSMarkerAnimationPop;
                                    //marker.icon = URL(string: icon)!;//self.downloadMarkerImage(iconUrl: icon, marker: marker);
                                    marker.title = name;
                                    marker.map = mapView;
                                }
                            }
                        }
                    } catch {
                        print("Something Wrong Happened")
                    }
                }
            }
        );
        task.resume();
        
        /**
         // Adding Many markers or nearby locations in map
         let camera = GMSCameraPosition.camera(withLatitude: 12.971891,longitude: 77.641154, zoom: 18);
         let mapView = GMSMapView.map(withFrame: .zero, camera: camera);
         
         let marker = GMSMarker();
         marker.position = camera.target;
         marker.title = "Indiranagar";
         marker.snippet = "Bengaluru, KA, India";
         marker.appearAnimation = kGMSMarkerAnimationPop;
         marker.map = mapView;
         view = mapView;
         
         let marker1 = GMSMarker();
         marker1.position = CLLocationCoordinate2D(latitude: 12.972249, longitude: 77.640746);
         marker1.appearAnimation = kGMSMarkerAnimationPop;
         marker1.map = mapView;
         
         let marker2 = GMSMarker();
         marker2.position = CLLocationCoordinate2D(latitude: 12.971964, longitude: 77.642140);
         marker2.appearAnimation = kGMSMarkerAnimationPop;
         marker2.map = mapView;
         */
    }
    
    // Only issues not working
    /*
    func downloadMarkerImage(iconUrl: String, marker: GMSMarker) -> UIImage {
        //print(iconUrl);
        let config = URLSessionConfiguration.default; // Session Configuration
        let session = URLSession(configuration: config); // Load configuration into Session
        //let formattedUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);//Not required
        let url = URL(string: iconUrl)!;
        var markerImage = #imageLiteral(resourceName: "default_marker.png");
        let task = session.downloadTask(with: url, completionHandler: {
            (data, response, error) in
            if(nil != error){
                print("Error:: ",error!);
            }else{
                if(nil != data){
                    let imagedata = data as? Data;
                    markerImage = UIImage(data: imagedata!)!;
                }
            }
        })
        task.resume();
        return markerImage;
    }
    */
    
}

// Don't known how this work, what i have done can be wrong
/*
extension UIImage {
    func downloadMarkerImage(from url: String, marker: GMSMarker) {
        let urlRequest = URLRequest(url: URL(string: url)!);
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if(nil == error){
                marker.icon = UIImage(data: data!);
            }
        });
        task.resume();
    }
}
 */

