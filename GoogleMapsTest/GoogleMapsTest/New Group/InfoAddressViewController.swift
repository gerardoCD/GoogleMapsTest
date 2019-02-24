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
        NotificationCenter.default.addObserver(self, selector: #selector(InfoAddressViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        aliasTextField.addTarget(self, action: #selector(myTargetFunction), for: UIControl.Event.touchDown)
        
        countryTextField.addTarget(self, action: #selector(myTargetFunction), for: UIControl.Event.touchDown)
        
        postalCodeTextField.addTarget(self, action: #selector(myTargetFunction), for: UIControl.Event.touchDown)
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func myTargetFunction(textField: UITextField) {
   
        moveTextField(textField, moveDistance: -250, up: true)
        
    }
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        localityTextField.text = address.locality
        thotoughfareTextField.text = address.thoroughfare
        subTorougjfanTextField.text = address.subThoroughfare
        postalCodeTextField.text = address.postalCode
        countryTextField.text = address.country
        aliasTextField.text = address.alias
        
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
                let pop = [key:
                    ["locality": localityTextField.text ,
                     "thoroughfare": thotoughfareTextField.text,
                     "subthoroughfare": subTorougjfanTextField.text ,
                     "postalcode": postalCodeTextField.text,
                     "country": countryTextField.text,
                     "alias": aliasTextField.text
                        
                    ]
                    ] as! [String:Any]
                
                ref.updateChildValues(pop)
                
                let alert = UIAlertController(title: "Congratulations", message: "You have a new adrress saved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in  self.navigationController?.popViewController(animated: true)}))
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
