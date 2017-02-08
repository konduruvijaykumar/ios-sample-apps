//
//  ViewController.swift
//  MapsDemoApp
//
//  Created by Vijay Konduru on 06/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

// https://www.youtube.com/watch?v=Idzn65L4p-A
// http://www.latlong.net/

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let location = CLLocationCoordinate2DMake(12.94982, 77.64302); // EGL Bangalore
        //let location = CLLocationCoordinate2DMake(12.971765, 77.596604); // Imagine Store, UB City Bangalore
        let location = CLLocationCoordinate2DMake(37.331837, -122.029586); // 6 Infinite Loop, Apple Inc, Cupertino, CA 95014, USA
        
        // How much to zoom
        //let span = MKCoordinateSpanMake(0.2, 0.2);
        //let span = MKCoordinateSpanMake(0.002, 0.002);
        let span = MKCoordinateSpanMake(0.0002, 0.0002);
        let region = MKCoordinateRegionMake(location, span);
        
        myMapView.setRegion(region, animated: true);
        
        let mapPointAnnotation = MKPointAnnotation();
        
        mapPointAnnotation.coordinate = location;
        //mapPointAnnotation.title = "Embassy Golf Links Business Park, Challaghatta, Bengaluru, Karnataka, India";
        //mapPointAnnotation.title = "Embassy Golf Links Business Park";
        //mapPointAnnotation.subtitle = "Challaghatta, Bengaluru, KA, IN";
        
        //mapPointAnnotation.title = "Imagine Store, UB City";
        //mapPointAnnotation.subtitle = "Bengaluru, KA, IN";
        
        mapPointAnnotation.title = "6 Infinite Loop, Apple Inc";
        mapPointAnnotation.subtitle = "Cupertino, CA 95014, USA";
        
        myMapView.addAnnotation(mapPointAnnotation);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

