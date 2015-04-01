//
//  ArticleListViewController.swift
//  kanshu
//
//  Created by Christopher Wood on 3/25/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Alert View Setup
    func showAlertView(title: String) {
        
        let alertView = UIAlertController(title: title, message: "\(title)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        alertView.addAction(cancelAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
        
    }
    
    // MARK: - TableViewController
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return sampleEntryList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return sampleEntryList[section].count
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "ArticleCell"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as ArticleListTableViewCell
        
        cell.entry = sampleEntryList[indexPath.section][indexPath.row]
        
        return cell
    }

    
    // MARK: - Instantiate Properties
    @IBOutlet weak var articleListTableView: UITableView!
    @IBAction func menuButton(sender: UIBarButtonItem) {
        showAlertView("Menu Button Pressed")
    }
    @IBAction func searchTextField(sender: UITextField) {
        showAlertView("Search Successful")
    }
    @IBOutlet weak var searchTextField: SearchTextField!

    private var articleListView: ArticleListView! { return view as ArticleListView }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
