//
//  PictureDetailView.swift
//  ccunsaProyecto
//
//  Created by galaxy on 13/11/24.
//

import SwiftUI

struct PictureDetailView: View {
    let picture: Pictures
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagen Principal
                AsyncImage(url: URL(string: picture.linkImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment:  .center)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                
                
                // Información básica
                VStack(alignment: .leading) {
                    Text(picture.name)
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    Text("Artista")
                        .font(.headline)
                    Text("\(picture.authorId)")
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
        //.ignoresSafeArea(.container, edges: .top)
    }
}

