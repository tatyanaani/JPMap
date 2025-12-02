//
//  Predators.swift
//  JPMap
//
//  Created by Tatyana on 30/11/2025.
//

import Foundation

class Predators {
    
    var allApexPredators: [ApexPredatorModel] = []
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
                allApexPredators = try decoder.decode([ApexPredatorModel].self, from: data)
                apexPredators = allApexPredators
            } catch{
                // in case we have error in do, we deal with them here in catch
                print("Error decoding JSON data: \(error)") // will print it in console
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredatorModel] {
        if searchTerm.isEmpty{
            return apexPredators
        } else {
//            return apexPredators.filter({$0.name.lowercased().contains(searchTerm.lowercased())})
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        apexPredators.sort {predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: ApexPredatorModel.APType){
        if type == .all{
            apexPredators = allApexPredators
        } else{
            apexPredators = allApexPredators.filter{predator in
                predator.type == type
            }
        }
    }
    
}
