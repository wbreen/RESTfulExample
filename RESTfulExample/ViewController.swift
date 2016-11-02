//
//  ViewController.swift
//  RESTfulExample
//
//  Created by William Breen on 11/2/16.
//  Copyright © 2016 William Breen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //anything that takes time (literally slower than instantly) has to be done off of the UIThread
    //so the user interface doesn't freeze up on the user while trying to do the calculation/whatever we ask it to do
    //the UIThread is the loop that is constantly updating the user interface
    //means you have to write multi-threaded code
    @IBAction func doRandomize(_ sender: UIButton) {
        RestApiManager.instance.getRandomUser(resultsHandler: self.myResultsHandler)
    }
    
    func myResultsHandler(json: JSON) {
        print(json)
        
        if let results = json["results"].array {        //look inside results array and return array given
            for entry in results {
                print(entry["email"].stringValue)
                //get email value to print out
                emailLabel.text = entry["email"].stringValue
                print(entry["picture"]["large"].stringValue)
                
                //DispatchQueue.main.async(){       THIS LINE GOES IN SOMEWHERE, MISSED SLIGHTLY IN CLASS, AND KIND OF LOST
                //get picture, have to do more work to get it
                if let url = URL(string: entry["picture"]["large"].stringValue){
                    //grab the data and stick it into a UIImage
                    do{
                        let data = try Data(contentsOf: url)
                        photoImageView.image = UIImage(data: data)
                    } catch {
                        print("no image")
                    }
                }
            }
        }
    }
    
    
}







