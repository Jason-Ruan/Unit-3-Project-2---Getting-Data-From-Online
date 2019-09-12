//
//  EpisodesFetchingClient.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/12/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class EpisodesFetchingClient {
    private init() {}
    static let manager = EpisodesFetchingClient()
    
    func getShowEpisodes(showID: Int, completionHandler: @escaping (Result<[ShowEpisodes], AppError>) -> () ) {
        let showEpisodesURLString = "http://api.tvmaze.com/shows/\(showID)/episodes"
        NetworkHelper.shared.fetchData(urlString: showEpisodesURLString) { (result) in
            switch result {
            case .failure:
                completionHandler(.failure(.noDataError))
            case .success(let data):
                do {
                    let allEpisodes = try JSONDecoder().decode([ShowEpisodes].self, from: data)
                    completionHandler(.success(allEpisodes))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
    
}
