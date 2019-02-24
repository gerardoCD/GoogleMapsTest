//
//  GoogleMapsModels.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
struct Address{
    var locality: String?
    var thoroughfare: String?
    var subThoroughfare: String?
    var postalCode: String?
    var country: String?
    var subAdministrativeArea:String?
    var alias: String?
    init(locality:String, thoroughfare:String, subThoroughfare:String, postalCode:String, country:String, subAdministrativeArea:String ) {
        self.locality = locality
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.postalCode = postalCode
        self.country = country
        self.subAdministrativeArea = subAdministrativeArea
    }
    
    init(locality:String, thoroughfare:String, subThoroughfare:String, postalCode:String, country:String, alias:String ) {
        self.locality = locality
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.postalCode = postalCode
        self.country = country
        self.alias = alias
    }
    init() {
        
    }
    
    
    static func allAddreess(completion: @escaping (_ address: [Address]?,Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users/\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            var address = [Address]()
            for event in snapshot.children.allObjects as! [DataSnapshot] {
                //getting values
                let eventObject = event.value as? [String: AnyObject]
                //let eventId = event.key
                let alias = eventObject?["alias"]
                let country = eventObject?["country"]
                let locality = eventObject?["locality"]
                let postalCode = eventObject?["postalcode"]
                let subThoroughfare = eventObject?["subthoroughfare"]
                let thoroughfare = eventObject?["thoroughfare"]
                
                address.append(Address(locality: locality as! String, thoroughfare: thoroughfare as! String, subThoroughfare: subThoroughfare as! String, postalCode: postalCode as! String, country: country as! String,  alias: alias as! String))
               
            }
            completion(address,true)
        })
    }
}
