//
//  ImageHelper.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/11/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation
import UIKit

struct ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    
    func getImage(imageURL: URL, completionHandler: @escaping (Result<UIImage, AppError>) -> () ) {
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.badURL))
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
                if let image = UIImage(data: data) {
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.badImageData))
                }
            default:
                completionHandler(.failure(.other(errorDescription: "Response Status Code not covered")))
            }
            }.resume()
        
    }
}
