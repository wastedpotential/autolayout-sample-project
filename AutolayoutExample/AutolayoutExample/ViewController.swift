//
//  ViewController.swift
//  AutolayoutExample
//
//  Created by BW on 3/11/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var phone1TextField: UITextField!
    @IBOutlet weak var phone1ErrorLabel: UILabel!
    @IBOutlet weak var phone1ErrorHeightConstraint: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone1ErrorHeightConstraint.constant = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
// MARK: - UITextField Delegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.layoutSubviews() //this line fixes an animation bug in the textfield
        validatePhone1()
    }
    
    
// MARK: - UIBarButton Actions
    
    @IBAction func saveBarButtonPressed(sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    
    
// MARK: - Validation
    
    func validatePhone1() -> Bool {
        if let phoneNumber = phone1TextField.text {
            if phoneNumber.characters.count > 0 {
                showError(phone1TextField, errorLabel:phone1ErrorLabel, errorHeightConstraint:phone1ErrorHeightConstraint, errorText: "There is an error")
                return false
            }
            else {
                hideError(phone1TextField, errorHeightConstraint:phone1ErrorHeightConstraint) //remove any existing errors
                return true
            }
        }
        return true
    }
    
    
    
// MARK: - TextField errors
    
    func hideError(textField:UITextField, errorHeightConstraint:NSLayoutConstraint) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        //animate error height to 0
        errorHeightConstraint.constant = 0.0
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func showError(textField:UITextField, errorLabel:UILabel, errorHeightConstraint:NSLayoutConstraint,  errorText:String) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.redColor().CGColor
        
        errorLabel.text = errorText
            
        //calculate how big the error label will need to be:
        let errorLabelSize = errorLabel.sizeThatFits(CGSize(width:errorLabel.frame.size.width, height: 300))
        
        //animate error height to show error:
        errorHeightConstraint.constant = errorLabelSize.height
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

