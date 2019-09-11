//
//  SeriesFetchingClient.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class SeriesFetchingClient {
    private init() {}
    static let manager = SeriesFetchingClient()
    private let allSeriesURLString = "http://api.tvmaze.com/shows"
    
    func getSeries(completionHandler: @escaping (Result<[Series], AppError>) -> () ) {
        NetworkHelper.shared.fetchData(urlString: allSeriesURLString) { (result) in
            switch result {
            case .failure:
                completionHandler(.failure(.noDataError))
            case .success(let data):
                do {
                    let tvSeriesDirectory = try JSONDecoder().decode(TVSeriesWrapper.self, from: data)
                    completionHandler(.success(tvSeriesDirectory.series))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
    
}
