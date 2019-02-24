//
//  AllInfoViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/24/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

class AllInfoViewController: UIViewController {
    
    var address = Address()
    
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var thoropughfareLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        aliasLabel.text = address.alias
        countryLabel.text = address.country
        localityLabel.text = address.locality
        postalCodeLabel.text = address.postalCode
        thoropughfareLabel.text = address.thoroughfare
    }
    

}
