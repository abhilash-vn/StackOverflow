//
//  NetworkManager.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//


import Foundation

/// Conforms to this to provide data loading service
protocol NetworkSession {
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

/// Making URLSession confrom to NetworkSession inorder to fetch data
extension URLSession: NetworkSession {
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.init(configuration: .default).dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}

/// Network Service for fethcing data from outside. Conform to this to be used by Data Service.
/// For example use this to fetch data from remote using URLSession or load data from local json to mock the service.
protocol NetworkService {
    
    /// Completion handler for the service. All the parameters are optional
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    /// Initialise network manager with the passed in session
    /// - Parameter session: The session who will be able to perfrom data loading
    init(session: NetworkSession)
    
    /// Fetche data from the url provided.
    /// - Parameters:
    ///   - urlString: The url in string format.
    ///   - completion: The completion handler that will be called on success or failure.
    func fetchData(from urlString: String, completion: @escaping completionHandler)
        
}

/// The real network manager for the app. This fetches data from server using URLSession.
struct SONetworkManager: NetworkService {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(from urlString: String, completion: @escaping completionHandler) {
        
        guard let url = URL(string: urlString) else {
            completion(nil,nil,SONetworkError.badURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        session.loadData(with: url) { (data, response, error) in
            print("\n♻️ Response: \(String(describing: response))")
            print("\n🚫 Error: \(String(describing: error))")
            
            completion(data,response,error)
        }
    }
    
}
