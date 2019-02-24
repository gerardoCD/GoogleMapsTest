//
//  ExtensionViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
