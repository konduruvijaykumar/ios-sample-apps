//
//  ViewController.swift
//  GMapsDemo
//
//  Created by Vijay Kondurura on 13/02/17.
//  Copyright © 2017 PJay. All rights reserved.
//

//https://developers.google.com/maps/documentation/ios-sdk/
//https://developers.google.com/maps/documentation/ios-sdk/start
//http://blog.swilliams.me/words/2015/03/31/tracking-down-an-exc-bad-access-with-swift/
//http://stackoverflow.com/questions/25353790/swift-project-crashing-with-thread-1-exc-bad-access-code-1-address-0x0
//https://developers.google.com/maps/documentation/ios-sdk/marker
//https://developers.google.com/maps/documentation/ios-sdk/map

//https://github.com/github/gitignore/blob/master/Objective-C.gitignore
//https://github.com/konduruvijaykumar/maps-sdk-for-ios-samples/blob/master/tutorials/current-places-on-map/.gitignore
//http://stackoverflow.com/questions/11197249/show-system-files-show-git-ignore-in-osx

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    //@IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        /**
         navigationItem.title = "Hello Map"
         
         let camera = GMSCameraPosition.camera(withLatitude: -33.868,
         longitude: 151.2086,
         zoom: 14)
         let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
         
         let marker = GMSMarker()
         marker.position = camera.target
         marker.snippet = "Hello World"
         marker.appearAnimation = kGMSMarkerAnimationPop
         marker.map = mapView
         
         view = mapView
        */
        
        /**
         // Create a GMSCameraPosition that tells the map to display the
         // coordinate -33.86,151.20 at zoom level 6.
         let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
         view = mapView
         
         // Creates a marker in the center of the map.
         let marker = GMSMarker()
         marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
         marker.title = "Sydney"
         marker.snippet = "Australia"
         marker.map = mapView
        */
        
        //let camera = GMSCameraPosition.camera(withLatitude: -33.868,longitude: 151.2086, zoom: 14);//Sydney, Australia
        //let camera = GMSCameraPosition.camera(withLatitude: 12.94982,longitude: 77.64302, zoom: 18);//EGL, Bangalore
        let camera = GMSCameraPosition.camera(withLatitude: 37.331837,longitude: -122.029586, zoom: 18);//Apple Inc, Cupertino, CA 95014, USA
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera);
        //mapView.mapType = kGMSTypeNone;//kGMSTypeTerrain;//kGMSTypeHybrid;//kGMSTypeNormal;//kGMSTypeSatellite;

        let marker = GMSMarker();
        marker.position = camera.target;
        marker.title = "Apple Inc";//marker.title = "Embassy Golf Links";//marker.title = "Sydney";
        marker.snippet = "Cupertino, CA 95014, USA";//marker.snippet = "Bengaluru, KA, India";//marker.snippet = "Australia";
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
        self.view = mapView;
        
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


}

