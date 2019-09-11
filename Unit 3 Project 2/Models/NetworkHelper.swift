//
//  NetworkHelper.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/11/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let shared = NetworkHelper()
    
    func fetchData(urlString: String, completionHandler: @escaping (Result<Data, AppError>) -> () ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.networkError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.badHTTPResponse))
                return
            }
            
            switch response.statusCode {
            case 404:
                completionHandler(.failure(.notFound))
            case 401,402:
                completionHandler(.failure(.unauthorized))
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.other(errorDescription: "Response Status Code not covered")))
            }
        }.resume()
        
    }
    
}
