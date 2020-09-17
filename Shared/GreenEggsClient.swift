//
//  GreenEggsClient.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 12/09/2020.
//

import Foundation

class GreenEggsClient {
    static func getUsers(
        success: @escaping ([User]?) -> Void,
        failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/persons/") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
    
    static func getCategories(
        success: @escaping ([String:Category]?) -> Void,
        failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/categories") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode([String:Category].self, from: data)
                    print(response)
                } catch {
                    print(error)
                }
                if let categoryResponse = try? JSONDecoder().decode([String:Category].self, from: data) {
                    success(categoryResponse)
                } else {
                    failure(nil,
                            "Could not decode response to [Category]")
                }
            }
        }.resume()
    }
    
    static func addFood(food: Food,
                        userId: String,
                        success: @escaping (Food) -> Void,
                        failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/persons/\(userId)/food/") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = try? JSONEncoder().encode(food)
        request.httpBody = body
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let foodResponse = try? JSONDecoder().decode(Food.self, from: data) {
                    success(foodResponse)
                } else {
                    failure(nil,
                            "Could not decode response to [User]")
                }
            }
        }.resume()
    }
    
    static func updateFood(food: Food,
                        userId: String,
                        success: @escaping (Food) -> Void,
                        failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/persons/\(userId)/food/\(food.id)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let body = try? JSONEncoder().encode(food)
        request.httpBody = body
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let foodResponse = try? JSONDecoder().decode(Food.self, from: data) {
                    success(foodResponse)
                } else {
                    failure(nil,
                            "Could not decode response to [User]")
                }
            }
        }.resume()
    }
    
    static func addUser(user: User,
                        success: @escaping ([User]?) -> Void,
                        failure: @escaping (Error?, String?) -> Void) {
        guard let url = URL(string: "https://olddp9jyu2.execute-api.eu-north-1.amazonaws.com/dev/api/persons/") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = try? JSONEncoder().encode(user)
        request.httpBody = body
       
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
