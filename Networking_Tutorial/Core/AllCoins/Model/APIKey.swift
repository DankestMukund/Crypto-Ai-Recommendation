//
//  APIKey.swift
//  Networking_Tutorial
//
//  Created by Mukund Madhav on 04/08/25.
//

import Foundation

enum APIKey {
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        // Add a check to ensure the key isn't empty or the placeholder
        if value.isEmpty || value == "YOUR_API_KEY" {
            fatalError("Please get a valid API key from Google AI Studio and replace 'YOUR_API_KEY' in GenerativeAI-Info.plist.")
        }
        return value
    }
}
