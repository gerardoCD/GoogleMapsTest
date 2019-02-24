//
//  InfoAddressViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import UIKit

class InfoAddressViewController: UIViewController {
    var address = Address()
    
    @IBOutlet weak var localityTextField: UITextField!
    @IBOutlet weak var thotoughfareTextField: UITextField!
    @IBOutlet weak var subTorougjfanTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var aliasTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        localityTextField.text = address.locality
        thotoughfareTextField.text = address.thoroughfare
        subTorougjfanTextField.text = address.subThoroughfare
        postalCodeTextField.text = address.postalCode
        countryTextField.text = address.country
        aliasTextField.text = address.alias
    }

}
