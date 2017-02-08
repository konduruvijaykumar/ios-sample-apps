//
//  ViewController.swift
//  MapAndLocationDemoApp
//
//  Created by Vijay Konduru on 07/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitudeData: Double = 0.0;
    var longitudeData: Double = 0.0;
    var placeTitle: String = "";
    var placeSubTitle: String = "";
    var didWeReceiveUpdate: Bool = false;
    
    //let locationManager = CLLocationManager();
    let locationManager: CLLocationManager = CLLocationManager();
    
    @IBOutlet weak var myMapView: MKMapView!
    
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
        // Note: make sure to reset data for lat, long, placeTitle, placeSubTitle. So that we can use that as condition empty. As i always was getting location data 3 to 5 times in this of my corelocation app
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
        doLoadMapWithLocation();
    }
    
    func doLoadMapWithLocation(){
        let location = CLLocationCoordinate2DMake(latitudeData, longitudeData);
        // How much to zoom
        let span = MKCoordinateSpanMake(0.0002, 0.0002);
        let region = MKCoordinateRegionMake(location, span);
        myMapView.setRegion(region, animated: true);
        
        let mapPointAnnotation = MKPointAnnotation();
        mapPointAnnotation.coordinate = location;
        mapPointAnnotation.title = placeTitle;
        mapPointAnnotation.subtitle = placeSubTitle;
        
        myMapView.addAnnotation(mapPointAnnotation);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

