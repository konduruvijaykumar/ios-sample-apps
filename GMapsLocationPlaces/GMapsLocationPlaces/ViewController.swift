//
//  ViewController.swift
//  GMapsLocationPlaces
//
//  Created by Vijay Konduru on 16/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

//https://developers.google.com/maps/documentation/ios-sdk/
//https://developers.google.com/maps/documentation/ios-sdk/start
//http://stackoverflow.com/questions/30987986/ios-9-not-opening-instagram-app-with-url-scheme

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitudeData: Double = 0.0;
    var longitudeData: Double = 0.0;
    var placeTitle: String = "";
    var placeSubTitle: String = "";
    var didWeReceiveUpdate: Bool = false;
    
    //let locationManager = CLLocationManager();
    let locationManager: CLLocationManager = CLLocationManager();
    
    // Trying to add Activity indicator from start of getting location to end of getting location, show maps. Also blocking user interaction on the UI or view in between for processing
    let uiActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // Might not be necessary for this app
        //self.locationManager.requestAlwaysAuthorization();
        self.locationManager.requestWhenInUseAuthorization();
        self.locationManager.startUpdatingLocation();
        //let lat = 33.7890;let lng = 33.7890;let type = "bank|atm";
        //let myString = "location="+"\(lat)"+"\(lng)"+"&"+"type="+"\(type)";
        //print(myString);
        startActivityIndicator();
    }
    
    func startActivityIndicator(){
        uiActivityIndicator.center = self.view.center;
        uiActivityIndicator.hidesWhenStopped = true;
        uiActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        view.addSubview(uiActivityIndicator);
        uiActivityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func stopActivityIndicator(){
        uiActivityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
    }
    
    func checkNotNil(_ sender: AnyObject?) -> Bool{
        // This utility method is not adding any value, this method might not be necessary
        // http://stackoverflow.com/questions/25809168/anyobject-and-any-in-swift
        // Returns true when not bill
        return (sender != nil);
    }
    
    func checkNilReturnObj(anyObj: Any?) -> String{
        if(anyObj != nil){
            return "\(anyObj!)";
        }else{
            return "";
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //NSLog("Error: \(error)"); // Used for logging
        print("Error: " + error.localizedDescription);
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
            
            (placemarks, error) -> Void in
            
            if(error != nil){
                print("Error: \(error)");
                return;
            }
            
            // Looks like this method is called so many times before it stops updating, this is causing a lot of problem. Let put some hack to avoid so many calls
            if(nil != placemarks && (placemarks!.count)>0 && !self.didWeReceiveUpdate){
                let pm = placemarks![0];
                self.didWeReceiveUpdate = true;
                self.doUpdateLocation(placemark: pm);
                return;
            }
            
        })
    }
    
    func doUpdateLocation(placemark: CLPlacemark) -> Void{
        self.locationManager.startUpdatingLocation();
        if(checkNotNil(self.locationManager.location)){
            latitudeData = self.locationManager.location!.coordinate.latitude;
            longitudeData = self.locationManager.location!.coordinate.longitude;
        }
        placeTitle = checkNilReturnObj(anyObj: placemark.name);
        placeSubTitle = checkNilReturnObj(anyObj: placemark.locality);
        //print(latitudeData);print(longitudeData);print(placeTitle);print(placeSubTitle);
        stopActivityIndicator();
        loadGoogleMap();
    }
    
    func loadGoogleMap(){
        // Loding logic for Google maps when location is found
        // IMP: atributes in json for nearby places
        // latitude: results -> geometry -> location -> lat
        // longitude: results -> geometry -> location -> lat
        // title: results -> name
        let camera = GMSCameraPosition.camera(withLatitude: latitudeData,longitude: longitudeData, zoom: 12);
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera);
        
        let marker = GMSMarker();
        marker.position = camera.target;
        marker.title = placeTitle;
        //marker.snippet = placeSubTitle;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = GMSMarker.markerImage(with: UIColor.cyan);
        marker.map = mapView;
        self.view = mapView;
        loadNearByPlaceMarkers(mapView: mapView);
    }
    
    func loadNearByPlaceMarkers(mapView: GMSMapView){
        //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=12.94982,77.64302&radius=3000&type=bank|atm&name=citi|icici|sbi|axis|hdfc&key=YOUR_SERVER_API_KEY";
        let config = URLSessionConfiguration.default; // Session Configuration
        let session = URLSession(configuration: config); // Load configuration into Session
        //let queryString = "location="+"\(latitudeData),\(longitudeData)"+"&radius=3000&type=bank|atm&name=citi|boa|chase|wells|amex&key=YOUR_SERVER_API_KEY";
        //let queryString = "location="+"\(latitudeData),\(longitudeData)"+"&radius=3000&type=bank|atm&key=YOUR_SERVER_API_KEY";
        let queryString = "location="+"\(latitudeData),\(longitudeData)"+"&radius=3000&type=bank|atm&name=citi|icici|sbi|axis|hdfc&key=YOUR_SERVER_API_KEY";
        //let queryString = "location="+"\(latitudeData),\(longitudeData)"+"&radius=3000&type=bank|atm&key=YOUR_SERVER_API_KEY";
        let myUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?\(queryString)";
        //let urlWithQueryParam = myUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
        let urlWithQueryParam = myUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
        
        //print(myUrl);//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.7873589,-122.408227&radius=3000&type=bank|atm&name=citi|boa|chase|wells fargo|amex&key=YOUR_SERVER_API_KEY
        //print(urlWithQueryParam!);//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.7873589,-122.408227&radius=3000&type=bank%7Catm&name=citi%7Cboa%7Cchase%7Cwells%20fargo%7Camex&key=YOUR_SERVER_API_KEY
        
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
                        print("Error fetching data")
                    }
                }
        }
        );
        
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

