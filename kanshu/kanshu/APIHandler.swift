//
//  APIHandler.swift
//  kanshu
//
//  Created by Christopher Wood on 3/19/15.
//  Copyright (c) 2015 Fluid Pixel Ltd. All rights reserved.
//

import Foundation

class APIHandler: NSObject, NSURLConnectionDelegate {
    
    class func sharedInstance() -> APIHandler {
        return apiHandlerSingletonGlobal
    }
    
    var sessionIDData: NSMutableData!
    
    private let signInURL = "***"
    private let loginURL = "***"
    
    func signUp(#params: [String:String], completion: (responseObject: AnyObject!, error: NSError!) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: signInURL)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var error: NSError?
        let requestBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
        if requestBody == nil {
            completion(responseObject: nil, error: error)
        }
        request.HTTPBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println("Data: \(data)")
            let strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
//            else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    var success = parseJSON["success"] as? Int
//                    println("Succes: \(success)")
//                }
//                else {
//                    // Woa, okay the json object was nil, something went wrong. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    println("Error could not parse JSON: \(jsonStr)")
//                }
//            }
        })
        
        task.resume()
    }
    
    func logIn(#username: String, password: String, completion: (responseObject: AnyObject!, error: NSError!) -> Void) {
        
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        var request = NSMutableURLRequest(URL: NSURL(string: loginURL)!)
        request.HTTPMethod = "GET"
        
        var error: NSError?
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let urlConnection = NSURLConnection(request: request, delegate: self)
        urlConnection!.start()
    }
    
    // Connection Delegate
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //NSURLConnection delegate method
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        //New request so we need to clear the data object
        sessionIDData = NSMutableData()
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        //Append incoming data
        sessionIDData.appendData(data)
    }
    
    //NSURLConnection delegate method
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        NSLog("connectionDidFinishLoading")
        println("SessionData: \(sessionIDData)")
        let html = NSString(data: sessionIDData, encoding: NSUTF8StringEncoding)
        println(html)
        println(html?.length)
    }
}

private let apiHandlerSingletonGlobal = APIHandler()