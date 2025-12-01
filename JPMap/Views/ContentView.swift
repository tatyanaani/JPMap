//
//  ContentView.swift
//  JPMap
//
//  Created by Tatyana on 18/11/2025.
//

import SwiftUI

struct ContentView: View {
    
    let predators = Predators()
    @State var searchText: String = ""
    var filteredDinos: [ApexPredatorModel]{
        if searchText.isEmpty{
            return predators.apexPredators
        } else {
//            return predators.apexPredators.filter({$0.name.lowercased().contains(searchText.lowercased())})
            return predators.apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
            
    var body: some View {
        NavigationStack {
            List (filteredDinos) {predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack(spacing: 20){
                        // dino image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white,radius: 2)
                        
                        VStack (alignment: .leading){
                            // dino name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // dino type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(5)
                            //                        .background(predator.type == "air" ? .green : predator.type == "land" ? .orange :.blue)
                                .background(predator.type.background)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }

                
            }
            .listStyle(.plain)
            .navigationTitle(Text("ApexPredators"))
            .searchable(text: $searchText)
            .autocorrectionDisabled(true)
            .animation(.default, value: self.searchText)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
