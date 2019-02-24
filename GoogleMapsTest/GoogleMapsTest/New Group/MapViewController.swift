//
//  MapViewController.swift
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
import MapKit


class MapViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    var latitude = CLLocationDegrees()
    var longuitude = CLLocationDegrees()
    
    @IBOutlet weak var secoundView: UIView!
    override func viewDidLoad() {
     
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
      if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
        
        latitude = (locationManager.location?.coordinate.latitude)!
        longuitude = (locationManager.location?.coordinate.longitude)!
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude,longitude: longuitude, zoom: 17)
        let mapView = GMSMapView.map(withFrame:  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: secoundView.frame.width, height: secoundView.frame.height)),camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        secoundView.addSubview(mapView)
        
        let markerPosition = GMSMarker()
        markerPosition.position = camera.target
        markerPosition.map = mapView
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self as? CLLocationManagerDelegate
        
        
        }
        
        

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        nowPositionGoogleMaps()
        self.locationManager.stopUpdatingLocation()
    }

    /** This funtion gets currently position */
    func nowPositionGoogleMaps(){

        // Get Coordinates
        latitude = (locationManager.location?.coordinate.latitude)!
        longuitude = (locationManager.location?.coordinate.longitude)!

        // Camera
        let camera = GMSCameraPosition.camera(withLatitude: latitude,longitude: longuitude, zoom: 17)

        //Draw the Map
        let mapView = GMSMapView.map(withFrame:  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: secoundView.frame.width, height:  secoundView.frame.height)),camera: camera)

        mapView.isMyLocationEnabled = true

        //Market for the position
        let markerPosition = GMSMarker()
        markerPosition.position = camera.target
        markerPosition.map = mapView
       
    }



    @IBAction func btnSave(_ sender: Any) {
        let Coords = CLLocation(latitude: latitude, longitude: longuitude)
        getAdressName(coords: Coords) { (addressAPI, success) in
            if success == true{
               self.performSegue(withIdentifier: "segueSave", sender: addressAPI)
                
            }
        }
    }


    @IBAction func btnSaved(_ sender: Any) {
    }
    
    func getAdressName(coords: CLLocation, completion: @escaping (_ address: Address?,Bool) -> Void){
        var addressAux = Address()
        CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
            if error != nil {
                completion(nil,false)
            } else {
                
                let place = placemark! as [CLPlacemark]
                if place.count > 0 {
                    let place = placemark![0]
                    if place.locality != nil {
                        addressAux.locality = place.locality ?? ""
                    }
                    if place.thoroughfare != nil {
                        addressAux.thoroughfare = place.thoroughfare ?? ""
                    }
                    if place.subThoroughfare != nil {
                       addressAux.subThoroughfare = place.subThoroughfare ?? ""
                    }
                    if place.postalCode != nil {
                        addressAux.postalCode = place.postalCode ?? ""
                    }
                    if place.country != nil {
                       addressAux.country = place.country ?? ""
                    }
                    if place.subAdministrativeArea != nil {
                       addressAux.subAdministrativeArea = place.subAdministrativeArea ?? ""
                    }
                    completion(addressAux,true)
                }
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InfoAddressViewController
        {
         let vc = segue.destination as? InfoAddressViewController
            vc?.address = (sender as? Address)!
        }
    }
    

}
