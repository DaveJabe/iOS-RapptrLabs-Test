//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import UIKit

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else { print("Unable to create URL"); return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { print("Error fetching data"); return }
            
            /* The following 'do' block certainly leaves potential for optimization; initially, I used a JSONDecoder instance, but upon running
             the application the decoder couldn't decode the data as Messages.
             
             I made a struct called 'Messages' for this purpose with a single variable -- var messageArray: [Message]
             
             This struct was removed, because instead of using JSONDecoder, I used JSONSerialization to return a Foundation object that could be
             manually mapped to an array of 'Message's. To facilitate this, I added an new initializer to the Message model.
             */
            
            do {
                var messages = [Message]()
                guard let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[[String:Any]]] else { print("error decoding data"); return }
                for item in result["data"]! {
                    let userID = item["user_id"] as! String
                    let username = item["name"] as! String
                    let avatarURL = item["avatar_url"] as! String
                    let message = item["message"] as! String
                    messages.append(Message(userID: userID,
                                            username: username,
                                            avatarURL: avatarURL,
                                            text: message))
                }
                completion(messages)
            }
            catch {
                errorHandler("error fetching data")
            }
        }
        task.resume()
    }
    
    func fetchProfilePic(avatarURL: String, completion: @escaping (UIImage) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: avatarURL) else { print("Invalid URL"); return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { errorHandler("Error fetching data"); return }
            completion(UIImage.init(data: data)!)
        }
        task.resume()
    }
}
