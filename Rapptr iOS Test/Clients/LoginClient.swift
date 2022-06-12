//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {
        
    func login(email: String, password: String, completion: @escaping (String, Int) -> Void, error errorHandler: @escaping (String?) -> Void) {
        let start = DispatchTime.now().rawValue
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php") else { print("Error: Could not create URL"); return }
        
        var request = URLRequest(url: url)
        
        let postString = "email=\(email)&password=\(password)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else { print("Did not receive data"); return }
            
            do {
                guard let todo = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any?] else { return }
                
                let totalTime = Int((DispatchTime.now().rawValue - start)/1000000)
                completion(todo["message"] as! String, totalTime)
            }
            catch {
                print("Error trying to convert data to JSON")
                errorHandler("Login Unsuccessful")
            }
        }
        task.resume()
    }
}


