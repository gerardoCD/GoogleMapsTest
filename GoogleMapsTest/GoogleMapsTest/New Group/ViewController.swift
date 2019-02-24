//
//  ViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import GoogleSignIn
import GoogleMaps
class ViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate of button Sign-In
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }
}

