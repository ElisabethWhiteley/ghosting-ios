//
//  GreenEggsClient.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 12/09/2020.
//

import Foundation

public class GreenEggsClient {
    func getUsers(success: @escaping ([User]?) -> Void,
                                  failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/users/") else {
            return
        }
        let request = URLRequest(url: url)
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let userResponse = try? JSONDecoder().decode([User].self, from: data) {
                                    success(userResponse)
                                } else {
                                    failure(nil,
                                            "Could not decode response to [User]")
                                }
                
                
                    
                }
            }.resume()
    }
    
}
