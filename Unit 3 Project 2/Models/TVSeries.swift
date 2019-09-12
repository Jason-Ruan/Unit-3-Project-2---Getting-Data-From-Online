//
//  TVSeries.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct Series: Codable {
    let id: Int
    let name: String
    let summary: String
    let rating: RatingWrapper
    let image: ImageWrapper
    
    struct RatingWrapper: Codable {
        let average: Double?
    }
    
}

struct ShowEpisodes: Codable {
    let name: String
    let season: Int
    let episode: Int
    let summary: String
    let image: ImageWrapper
    
    private enum CodingKeys: String, CodingKey {
        case name
        case season
        case episode = "number"
        case summary
        case image
    }
}

struct ImageWrapper: Codable {
    let mediumImage: URL
    let originalImage: URL
    
    private enum CodingKeys: String, CodingKey {
        case mediumImage = "medium"
        case originalImage = "original"
    }
}
