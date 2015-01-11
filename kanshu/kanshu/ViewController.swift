//
//  ViewController.swift
//  kanshu
//
//  Created by Stuart Varrall on 11/01/2015.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var readingAbilityField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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
	@IBAction func signinAction(sender: UIButton) {
		self.showAlertView("Sign In")
	}

	@IBAction func signupAction(sender: UIButton) {
		self.showAlertView("Sign Up")
	}

	@IBAction func skipAction(sender: UIButton) {
		self.showAlertView("Skip")
	}
	
	//Text Field Delegates
	func textFieldDidBeginEditing(textField: UITextField) {

	}
}

