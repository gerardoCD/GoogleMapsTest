//
//  InfoAddressViewController.swift
//  GoogleMapsTest
//
//  Created by Gerardo Castillo Duran  on 2/23/19.
//  Copyright © 2019 Gerardo Castillo Duran . All rights reserved.
//

import UIKit
import Firebase
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
//        NotificationCenter.default.addObserver(self, selector: #selector(InfoAddressViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(InfoAddressViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
 
    
    @IBAction func bbu(_ sender: UITextField) {
        debugPrint("Hola")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        localityTextField.text = address.locality
        thotoughfareTextField.text = address.thoroughfare
        subTorougjfanTextField.text = address.subThoroughfare
        postalCodeTextField.text = address.postalCode
        countryTextField.text = address.country
        aliasTextField.text = address.alias
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if aliasTextField.text != ""{
            if Auth.auth().currentUser != nil {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let ref = Database.database().reference().child("users/\(uid)")
                let key = ref.childByAutoId().key
                let push = [key:
                    ["locality": address.locality,
                     "thoroughfare": address.thoroughfare,
                     "subthoroughfare": address.subThoroughfare,
                     "postalcode": address.postalCode,
                     "country": address.country,
                     "alias": address.alias
                        
                    ]
                    ] as! [String:Any]
                
                ref.setValue(push)
                
                let alert = UIAlertController(title: "Congratulations", message: "You have a new adrress saved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "You're no loged", message: "Login before to try after", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            }else{
            let alert = UIAlertController(title: "You camps are empty", message: "Put some nickName please", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
      
    }
    
}
