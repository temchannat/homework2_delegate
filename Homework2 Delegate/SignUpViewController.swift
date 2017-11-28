//
//  ViewController.swift
//  Homework2 Delegate
//
//  Created by Channat Tem on 11/21/17.
//  Copyright © 2017 Channat Tem. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var countryCodeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        phoneNumberTextField.borderStyle = .roundedRect
        emailTextField.borderStyle = .roundedRect
        signUpButton.layer.cornerRadius = 15
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let usernameCount = usernameTextField.text!.characters.count
        let email = emailTextField.text!
        if  usernameCount <= 3 || usernameCount > 15 {
            alert(title: "Invalid Username", message: "USERNAME range is in between 3 and 15")
            usernameTextField.becomeFirstResponder()
            return false
        }
        let checkValidEmail = isValidEmail(email: email)
        if !checkValidEmail {
            alert(title: "Invalid Email", message: "example@email.com")
            return false
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultViewController = segue.destination as? ResultViewController else { return }
        resultViewController.username = usernameTextField.text?.uppercased()
    }
    
    
    @IBAction func clearTextFieldsWhenUnWind(_ sender: UIStoryboardSegue) {
        // if the source come from ResultViewControoler then clear the textFields
//        guard let resultViewController = sender.source as? ResultViewController else { return }
        usernameTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
        emailTextField.text?.removeAll()
        phoneNumberTextField.leftView = nil
        phoneNumberTextField.text?.removeAll()
        phoneNumberTextField.placeholder = "(+855) 012-345-6789"

    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            phoneNumberTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    
    func alert(title:String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}


// Check Phone Number TextField
extension SignUpViewController {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // add (+855) to phoneNumberTextField
        if textField.isEqual(phoneNumberTextField)  {
            countryCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: phoneNumberTextField.bounds.height))
            countryCodeLabel.text = " (+855)"
            phoneNumberTextField.addSubview(countryCodeLabel)
            phoneNumberTextField.leftView = countryCodeLabel
            phoneNumberTextField.leftViewMode = .always
            phoneNumberTextField.placeholder = "012-345-6789"
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEqual(phoneNumberTextField) {
            let char = string.cString(using: String.Encoding.utf8)
            let isBackSpace: Int = Int(strcmp(char, "\u{8}"))
            // check if user pressed delete key
            if isBackSpace != -8 {
                let phoneNumber = phoneNumberTextField.text!
                let digitCount = phoneNumber.characters.count
                if  digitCount == 3  {
                    phoneNumberTextField.text = phoneNumber + "-"
                } else if digitCount == 7 {
                    phoneNumberTextField.text = phoneNumber + "-"
                } else if digitCount == 12 {
                    phoneNumberTextField.endEditing(false)
                }
            }
        }
        return true
    }
    
}


