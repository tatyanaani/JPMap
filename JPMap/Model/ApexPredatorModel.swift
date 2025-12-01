//
//  ApexPredatorModel.swift
//  JPMap
//
//  Created by Tatyana on 30/11/2025.
//

import Foundation
import SwiftUI

struct ApexPredatorModel: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum APType: String, Decodable {
        case land
        case air
        case sea
        
        var background: Color{
            switch self {
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            }
        }
    }
}

