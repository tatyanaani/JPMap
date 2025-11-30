//
//  Predators.swift
//  JPMap
//
//  Created by Tatyana on 30/11/2025.
//

import Foundation

class Predators {
    
    var apexPredators: [ApexPredatorModel] = []
    
    init() {
        decodeData()
    }
    
    func decodeData() {
        // bundle.name - where our project is on mac
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do{
                // where we do decoding work
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // because we have names in json in snake case (movie_scenes) and we have them in camel case in swift (movieScenes)
                apexPredators = try decoder.decode([ApexPredatorModel].self, from: data)
            } catch{
                // in case we have error in do, we deal with them here in catch
                print("Error decoding JSON data: \(error)") // will print it in console
            }
        }
    }
}
