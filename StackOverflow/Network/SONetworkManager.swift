//
//  NetworkManager.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//


import Foundation


/// Network Service for fethcing data from outside. Conform to this to be used by Data Service.
/// For example use this to fetch data from remote using URLSession or load data from local json to mock the service.
protocol NetworkService {
    
    /// Completion handler for the service. All the parameters are optional
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    /// Fetche data from the url provided.
    /// - Parameters:
    ///   - urlString: The url in string format.
    ///   - completion: The completion handler that will be called on success or failure.
    func fetchData(from urlString: String, completion: @escaping completionHandler)
    
}


/// The real network manager for the app. This fetches data from server using URLSession.
struct SONetworkManager: NetworkService {
    
    func fetchData(from urlString: String, completion: @escaping completionHandler) {
        
        guard let url = URL(string: urlString) else {
            completion(nil,nil,SONetworkError.badURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        URLSession.init(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            
            print("\n\n ♻️ Response: \(String(describing: response))")
            print("\n\n 🚫 Error: \(String(describing: error))")
            
            if let dataString = data?.prettyPrintedJSONString {
                print("JSON Data: \(dataString)")
            }
            
            completion(data,response,error)
            
        }.resume()
        
    }
    
}
