//
//  PredatorMap.swift
//  JPMap
//
//  Created by Tatyana on 05/12/2025.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    
    @State var position: MapCameraPosition
    let predators = Predators()
    
    @State var showPopover: Bool = false
    
    @State var satellite = false
    
    var body: some View {
        Map(position: $position){
            ForEach(predators.apexPredators) { predator in
                Annotation(
                    predator.name,
                    coordinate: predator.location) {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .shadow(color: .white, radius: 3)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                showPopover.toggle()
                            }
                            .popover(isPresented: $showPopover, attachmentAnchor: .point(.top)) {
                                VStack(alignment: .leading){
                                    Text(predator.name)
                                        .fontWeight(.bold)
                                        .font(.title)
                                    Text(predator.type.rawValue)
                                        .font(.title2)
                                        .padding(3)
                                        .background(predator.type.background)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("Movies")
                                        .font(.title)
                                        .padding(.vertical, 4)
                                    ForEach(predator.movies, id: \.self){movie in
                                        Text(movie)
                                    }
                                    
                                }
                                .padding(10)
                                .presentationCompactAdaptation(.popover)
                            }
                    }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic): .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 3)
                    .padding(8)
            }

        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(
        position: .camera(
            MapCamera(
                centerCoordinate: Predators().apexPredators[2].location,
                distance: 1000,
                heading: 250,
                pitch: 80
            )
        )
    )
    .preferredColorScheme(.dark)
}
