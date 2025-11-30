//
//  ApexPredatorModel.swift
//  JPMap
//
//  Created by Tatyana on 30/11/2025.
//

import Foundation

struct ApexPredatorModel: Decodable {
    
    let id: Int
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

