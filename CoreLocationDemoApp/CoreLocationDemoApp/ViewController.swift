//
//  ViewController.swift
//  CoreLocationDemoApp
//
//  Created by Vijay Konduru on 06/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// https://www.youtube.com/watch?v=kkVI3njOlqU
// http://www.appcoda.com/how-to-get-current-location-iphone-user/
// http://stackoverflow.com/questions/24062509/location-services-not-working-in-ios-8
// http://nevan.net/2014/09/core-location-manager-changes-in-ios-8/

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();

    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var addressText: UITextView!
    
    var addressDetails: String = "";
    var latitudeData: Double = 0.0;
    var longitudeData: Double = 0.0;
    var didWeReceiveUpdate: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // Not necessary for this app
        //self.locationManager.requestAlwaysAuthorization();
        self.locationManager.requestWhenInUseAuthorization();
        // Start on click on button to get information
        //self.locationManager.startUpdatingLocation();
    }
    
    
    @IBAction func getMyLocation(_ sender: Any) {
        self.locationManager.startUpdatingLocation();
        // reset data on click of get my location again or at start
        self.addressDetails = "";
        self.latitudeData = 0.0;
        self.longitudeData = 0.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // location manager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("\(manager.location?.coordinate.latitude)");
        //print("\(manager.location?.coordinate.longitude)");
        // We can try this to solve multiple values of location data coming -- Not sure give it a try
        //locations.first;
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
            
            (placemarks, error) -> Void in
            
            if(error != nil){
                print("Error: \(error)");
                return;
            }
            
            // Looks like this method is called so many times before it stops updating, this is causing a lot of problem. Let put some hack to avoid so many calls
            if(placemarks != nil && (placemarks!.count) > 0 && !self.didWeReceiveUpdate){
                let pm = placemarks![0];
                self.didWeReceiveUpdate = true;
                self.displayLocationInfo(placemark: pm);
                return;
            }
            
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation();
        if(self.locationManager.location != nil){
            // Note: The below hack of checking with 0.0 and "" for lat, long and address is not required. As we solved the problem using didWeReceiveUpdate variable.
            //if(latitudeData == 0.0){
            //print(self.locationManager.location!.coordinate.latitude);
            latitudeData = self.locationManager.location!.coordinate.latitude;
            self.latitudeLabel.text = "\(latitudeData)";
            //}
            //if(longitudeData == 0.0){
            //print(self.locationManager.location!.coordinate.longitude);
            longitudeData = self.locationManager.location!.coordinate.longitude;
            self.longitudeLabel.text = "\(longitudeData)";
            //}
        }
        //if(self.addressDetails == ""){
        //print(placemark.name!);
        //print(placemark.thoroughfare!); // Avoiding due to some data repeat
        //print(placemark.subThoroughfare!); // Not Imp
        //print(placemark.locality!);
        //print(placemark.administrativeArea!);
        //print(placemark.postalCode!);
        //print(placemark.country!);
        // Note: the address is some times coming as old value, but lat, long values change. Please verify
        self.addressDetails = "\(checkNil(anyObj: placemark.name))\n\(checkNil(anyObj: placemark.locality))\n\(checkNil(anyObj: placemark.administrativeArea))\n\(checkNil(anyObj: placemark.postalCode))\n\(checkNil(anyObj: placemark.country))";
        //addressDetails += checkNil(anyObj: placemark.name)+"\n";
        //addressDetails += checkNil(anyObj: placemark.location)+"\n";
        //addressDetails += checkNil(anyObj: placemark.administrativeArea)+"\n";
        //addressDetails += checkNil(anyObj: placemark.postalCode)+"\n";
        //addressDetails += checkNil(anyObj: placemark.country);
        print(addressDetails);
        self.addressText.text = self.addressDetails;
        //}
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription);
    }
    
    func checkNil(anyObj: Any?) -> String{
        if(anyObj != nil){
            return "\(anyObj!)";
        }else{
            return "";
        }
    }

}

