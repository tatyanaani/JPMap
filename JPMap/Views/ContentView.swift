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
    @State var alphabetical = false
    @State var currentSelection = ApexPredatorModel.APType.all
    
    var filteredDinos: [ApexPredatorModel]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation (.bouncy) {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "textformat" : "film")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker("filter", selection: $currentSelection.animation()) {
                            ForEach(ApexPredatorModel.APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
