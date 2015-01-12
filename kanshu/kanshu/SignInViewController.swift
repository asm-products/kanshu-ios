//
//  SignInViewController.swift
//  kanshu
//
//  Created by Stuart Varrall on 12/01/2015.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var emailAddressField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	//Alert View
	func showAlertView(title: String) {
		
		let alertView = UIAlertController(title: title, message: "\(title) Button Pressed", preferredStyle: UIAlertControllerStyle.Alert)
		
		let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel) { action -> Void in
			//Just dismiss the action sheet
		}
		
		alertView.addAction(cancelAction)
		
		self.presentViewController(alertView, animated: true, completion: nil)
		
	}
	
	//Button Actions
	@IBAction func signInAction(sender: AnyObject) {
		showAlertView("Sign In")
	}
	
	@IBAction func forgotPasswordAction(sender: AnyObject) {
		showAlertView("Forgot Password")
	}
	
	//TextField Delegate
	func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
	{
		textField.resignFirstResponder()
		return true;
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		if textField.text.isEmpty {
			switch textField.tag
			{
			case 0:
				textField.text = "E-mail Address"
			case 1:
				textField.text = "Password"
			default:
				textField.text = ""
			}
		}
	}
	
}
