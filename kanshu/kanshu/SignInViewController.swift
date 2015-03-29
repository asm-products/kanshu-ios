//
//  SignInViewController.swift
//  kanshu
//
//  Created by Stuart Varrall on 12/01/2015.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    let apiHandler = APIHandler.sharedInstance()
    
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGestureRecognizer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Gesture Recognizer for tapping screen to get rid of keyboard
    func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped:")
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func viewTapped(gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .Began: fallthrough
        case .Changed: fallthrough
        case .Ended: dismissKeyboard()
        default: break
        }
    }
    
    // Exact function that dismisses keyboard
    func dismissKeyboard() {
        for textField in [emailField, passwordField] {
            if textField.isFirstResponder() {
                textField.resignFirstResponder()
            }
        }
    }
    
	//MARK: - Alert View
	func showAlertView(title: String) {
		
		let alertView = UIAlertController(title: title, message: "\(title)", preferredStyle: UIAlertControllerStyle.Alert)
		
		let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel) { action -> Void in
			//Just dismiss the action sheet
		}
		
		alertView.addAction(cancelAction)
		
		self.presentViewController(alertView, animated: true, completion: nil)
		
	}
	
	//MARK: - Storyboard Items
    //MARK: Button Actions
	@IBAction func signInAction(sender: AnyObject) {
        if emailField.text.isEmpty == false && passwordField.text.isEmpty == false {
            apiHandler.logIn(username: emailField.text, password: passwordField.text, completion: { resultObject, error in
                if error != nil {
                    println("Err: \(error)")
                    println("RO: \(resultObject)")
                } else { println("RO: \(resultObject)") }
            })
            showAlertView("Sign In In Progress")
        } else if emailField.text.isEmpty {
            showAlertView("Please enter your email address")
        } else if passwordField.text.isEmpty {
            showAlertView("Please enter your password")
        } else {
            showAlertView("This should never happen")
        }
        performSegueWithIdentifier("signInToArticleListSegue", sender: self)
	}
	
	@IBAction func forgotPasswordAction(sender: AnyObject) {
		showAlertView("Forgot Password")
	}
	
	//MARK: TextField Delegate
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
