//
//  AppError.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/11/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

enum AppError: Error {
    case noDataError
    case badHTTPResponse
    case badURL
    case badURLResponse
    case networkError
    case decodingError
    case badJSONError
    case notFound
    case unauthorized
    case badImageData
    case other(errorDescription: String)
}
