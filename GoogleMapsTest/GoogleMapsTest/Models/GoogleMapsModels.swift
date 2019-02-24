//
//  GoogleMapsModels.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import Foundation


struct Address{
    var locality: String?
    var thoroughfare: String?
    var subThoroughfare: String?
    var postalCode: String?
    var country: String?
    var subAdministrativeArea:String?
    init(locality:String, thoroughfare:String, subThoroughfare:String, postalCode:String, country:String, subAdministrativeArea:String ) {
        self.locality = locality
        self.thoroughfare = thoroughfare
        self.subThoroughfare = subThoroughfare
        self.postalCode = postalCode
        self.country = country
        self.subAdministrativeArea = subAdministrativeArea
    }
    init() {
        
    }
}
