//
//  ViewController.swift
//  kanshu
//
//  Created by Stuart Varrall on 11/01/2015.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var readingAbilityField: UITextField!
	
	@IBOutlet weak var readingAbiiltyButton: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	let ability = ["Absolute Beginner", "HSK 1","HSK 2","HSK 3","HSK 4","HSK 5","HSK 6"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//we hide the ability selection tableview
		tableView.hidden = true
		
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
	
	@IBAction func currentAbilityAction(sender: AnyObject) {
		
		tableView.hidden = false
		self.view.endEditing(true);
	}
	
	//TextField Delegate
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
	
	//TableView
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
		
		readingAbiiltyButton.setTitle(ability[indexPath.row], forState: UIControlState.Normal)
		
		tableView.hidden = true
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
	}
}

