//
//  PredatorDetail.swift
//  JPMap
//
//  Created by Tatyana on 03/12/2025.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    let predator: ApexPredatorModel
    @State var position: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        
        GeometryReader{geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing){
                    // bg image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(
                                        color: .clear,
                                        location: 0.8
                                    ),
                                    Gradient.Stop(
                                        color: .black,
                                        location: 1
                                    )],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    
                    // dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 10)
                        .offset(y:20)
                }
                VStack(alignment: .leading){
                    // dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    // dino location
                    NavigationLink{
                        PredatorMap(
                            position: .camera(
                                MapCamera(
                                    centerCoordinate: predator.location,
                                    distance: 1000,
                                    heading: 250,
                                    pitch: 80
                                )
                            )
                        )
                            .navigationTransition(
                                .zoom(
                                    sourceID: 1,
                                    in: namespace
                                )
                            )
                    } label:{
                        Map(position: $position) {
                            Annotation(
                                predator.name,
                                coordinate: predator.location
                            ) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.red)
                                    .font(.largeTitle)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .font(.title)
                                .padding(10)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .overlay(alignment: .topLeading){
                            Text("Current Location")
                                .padding(5)
                                .background(.black.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    
                    // movies dino appears in
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top, 10)
                        .padding(.bottom, 2)

                    ForEach(predator.movies, id: \.self){movie in
                        Text("•"+movie)
                            .font(.subheadline)
                    }
                    // movie moments
                    Text("Movie moments")
                        .font(.title)
                        .padding(.top, 10)
                    
                    ForEach(predator.movieScenes,){scene in
                        Text(scene.movie)
                            .font(.title)
                            .padding(.top, 10)
                        Text(scene.sceneDescription)
                            .font(.subheadline)
                            .padding(.top, 1)
                    }
                    
                    // link
                    Text("More info here")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    if let url = URL(string: predator.link) {
                        Link(predator.link, destination: url)
                            .font(.caption)
                            .foregroundStyle(.teal)
                    }
                }
                .padding()
                .padding(.bottom, 20)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    
    let predator = Predators().apexPredators[10]
    NavigationStack{
        PredatorDetail(predator: predator, position: .camera(
            MapCamera(
                centerCoordinate: predator.location,
                distance: 30000
            )))
        .preferredColorScheme(.dark)
    }
}
