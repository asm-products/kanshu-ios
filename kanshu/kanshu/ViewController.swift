//
//  ViewController.swift
//  kanshu
//
//  Created by Stuart Varrall on 11/01/2015.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let apiHandler = APIHandler.sharedInstance()
    
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var readingAbilityField: UITextField!
	
	@IBOutlet weak var readingAbilityButton: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	let ability = ["Absolute Beginner", "HSK 1","HSK 2","HSK 3","HSK 4","HSK 5","HSK 6"]
	
    // MARK: - Controller Lifecycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        // If the user clicks the background screen while typing, the keyboard should dismiss.
        createGestureRecognizer()
        
		//we hide the ability selection tableview
		tableView.hidden = true
		
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
        for textField in [emailField, usernameField, passwordField] {
            if textField.isFirstResponder() {
                textField.resignFirstResponder()
            }
        }
    }
    
	// MARK: - Alert View
	func showAlertView(title: String) {
	
		let alertView = UIAlertController(title: title, message: "\(title)", preferredStyle: UIAlertControllerStyle.Alert)
		
		let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel) { action -> Void in
			//Just dismiss the action sheet
		}
		
		alertView.addAction(cancelAction)
		
		self.presentViewController(alertView, animated: true, completion: nil)
		
	}
	
	// MARK: - Storyboard Elements
    // MARK: Button Actions
	@IBAction func signinAction(sender: UIButton) {
	}

	@IBAction func signupAction(sender: UIButton) {
        if passwordField.text.isEmpty == false && emailField.text.isEmpty == false {
            apiHandler.signUp(params: ["password": passwordField.text, "email":emailField.text, "userBio":" ", "country":" "], completion: { resultObject, error in
                if error != nil {
                    println("Err: \(error)")
                    println("RO: \(resultObject)")
                } else { println("RO: \(resultObject)") }
            })
            self.showAlertView("Sign Up In Progress")
        } else if passwordField.text.isEmpty {
            showAlertView("Please enter a password")
        } else if emailField.text.isEmpty {
            showAlertView("Please enter an email address")
        } else {
            showAlertView("This should never happen")
        }
        performSegueWithIdentifier("signUpToArticleListSegue", sender: self)
	}

	@IBAction func skipAction(sender: UIButton) {
		self.showAlertView("Skip")
	}
	
	@IBAction func currentAbilityAction(sender: AnyObject) {
		
		tableView.hidden = false
		self.view.endEditing(true);
	}
	
	//MARK: TextField Delegate
	func textFieldDidBeginEditing(textField: UITextField) {
		tableView.hidden = true
	}
	
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
				textField.text = "Email"
			case 1:
				textField.text = "Username"
			case 2:
				textField.text = "Password"
			default:
				textField.text = ""
			}
		}
	}
	
	// MARK: TableView
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ability.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("abilityCell", forIndexPath:indexPath) as UITableViewCell
		
		cell.textLabel?.text = ability[indexPath.row]
		cell.textLabel?.textColor = UIColor.lightGrayColor()
		cell.textLabel?.font = UIFont.systemFontOfSize(14)
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		readingAbilityButton.setTitle(ability[indexPath.row], forState: UIControlState.Normal)
		
		tableView.hidden = true
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
	}
	
	//segue unwinding
	@IBAction func unwindToViewController (sender: UIStoryboardSegue){
		
	}
}

