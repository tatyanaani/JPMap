//
//  PredatorDetail.swift
//  JPMap
//
//  Created by Tatyana on 03/12/2025.
//

import SwiftUI

struct PredatorDetail: View {
    
    let predator: ApexPredatorModel
    
    var body: some View {
        
        GeometryReader{geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing){
                    // bg image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    
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
                    
                    // movies dino appears in
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top, 1)
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
                    if !predator.link.isEmpty {
                        Link(predator.link, destination: URL(string: predator.link)!)
                            .font(.caption)
                    }
                }
                .padding()
                .padding(.bottom, 20)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredators[0])
        .preferredColorScheme(.dark)
}
