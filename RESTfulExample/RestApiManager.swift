//
//  RestApiManager.swift
//  RESTfulExample
//
//  Created by William Breen on 11/2/16.
//  Copyright © 2016 William Breen. All rights reserved.
//

//THIS FILE CONTAINS:
//all the code that interacts with things from the web
import Foundation

class RestApiManager {
    static let instance = RestApiManager()
    //static - can only have one instance of something, don't have to dynamically create it
        //in this case, it exists without calling the initializer (or constructor [Java]), dont have to create it
    
    let baseURL = "https://api.randomuser.me/"
    
    func getRandomUser(resultsHandler: @escaping ((JSON) -> Void)) {
        makeHTTPGetRequest(path: baseURL, resultsHandler)
        
    }
    
    //MARK: Perform a GET request
    private func makeHTTPGetRequest(path: String, _ resultsHandler: @escaping ((JSON) -> Void)){      //asyncronus func: doesn't happen at regular intervals
                //resultsHandler connects the two threads
        
        let config = URLSessionConfiguration.default            //setup
        let session = URLSession(configuration: config)         //setup
        let url = URL(string: path)!                            //setup, "!" unwraps optional
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                if let jsonData = data {
                    let json = JSON(data: jsonData)
                    resultsHandler(json)
                }
            }
        })
        
        task.resume()
    }
    
    
}
