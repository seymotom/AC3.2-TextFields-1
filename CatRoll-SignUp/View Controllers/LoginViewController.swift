//
//  LoginViewController.swift
//  CatRoll-SignUp
//
//  Created by Louis Tur on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\n + \(textField.debugId) SHOULD BEGIN")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("\n + \(textField.debugId) DID BEGIN")
        errorLabel.isHidden = true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("\n + \(textField.debugId) SHOULD END")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\n + \(textField.debugId) DID END")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\n + \(textField.debugId) SHOULD RETURN")
        
        _ = self.textFieldsAreValid()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameTextField && string != "" {
            if self.string(string, containsOnly: CharacterSet.letters.union(CharacterSet.whitespaces)) == false {
                updateErrorLabel(with: "Invalid character")
            } else {
                errorLabel.isHidden = true
            }
            return self.string(string, containsOnly: CharacterSet.letters.union(CharacterSet.whitespaces))
        }
        errorLabel.isHidden = true
        return true
    }
    
    // MARK: - Validations
    func textFieldsAreValid() -> Bool {
        // 1. some set up
        let textFields: [UITextField] = [self.nameTextField, self.passwordTextField]
        let minimumLengthRequireMents: [UITextField : Int] = [self.nameTextField : 1, self.passwordTextField : 6]
        // 2. iterrate over the text fields
        for textField in textFields {
            if let charCount = textField.text?.characters.count, let minimum = minimumLengthRequireMents[textField] {
                if charCount < minimum {
                    updateErrorLabel(with: "\(textField.placeholder!.capitalized) requires at least \(minimum) characters")
                }
            }
        }
        checkForTwoNames(name: self.nameTextField.text)
        checkPassword(password: self.passwordTextField.text)
        
        return true
    }
    
    func textField(_ textField: UITextField, hasMinimumCharacters minimum: Int) -> Bool {
        if let tft = textField.text {
            return tft.characters.count >= minimum
        } else {
            return false
        }
    }
    
    func string(_ string: String, containsOnly characterSet: CharacterSet) -> Bool {
        if string.rangeOfCharacter(from: characterSet) != nil {
            return true
        } else {
            return false
        }
    }
    
    func updateErrorLabel(with message: String) {
        if self.errorLabel.isHidden {
            self.errorLabel.isHidden = false
        }
        self.errorLabel.text = message
        self.errorLabel.textColor = UIColor.red
        self.errorLabel.backgroundColor = UIColor.red.withAlphaComponent(0.25)
    }
    
    func checkForTwoNames(name: String?) {
        if let nameStr = name {
            self.nameTextField.text = nameStr.trimmingCharacters(in: .whitespacesAndNewlines)
            let nameArr = nameStr.components(separatedBy: " ")
            if nameArr.count < 2 {
                updateErrorLabel(with: "Must enter at least a first and last name")
            }
        }
    }
    
    func checkPassword(password: String?) {
        if let passStr = password {
            
            updateErrorLabel(with: "Password must contain at least 1 number")
        }
    }
}





// MARK: - UI Helper
// (add the label update function here when the lesson calls for it)


// MARK: - UITextFieldDelegate
// (add delegate functions below here)

