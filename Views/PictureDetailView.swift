//
//  PictureDetailView.swift
//  ccunsaProyecto
//
//  Created by galaxy on 13/11/24.
//

import SwiftUI

struct PictureDetailView: View {
    let picture: Picture
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagen Principal
                AsyncImage(url: URL(string: picture.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 500)
                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
                }
                
                // Información básica
                VStack(alignment: .leading) {
                    Text(picture.title)
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    Text("Artista")
                        .font(.headline)
                    Text(picture.author)
                        .padding(.bottom)
                        
                    Text("Tecnica")
                        .font(.headline)
                    Text(picture.technique)
                        .padding(.bottom)
                    
                    Text("Categoria")
                        .font(.headline)
                    Text(picture.category)
                        .padding(.bottom)
                    
                    Text("Descripcion")
                        .font(.headline)
                    Text(picture.description)
                        .padding(.bottom)

                    Text("Año: \(picture.year)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

