//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    
    @StateObject private var pictureViewModel = PictureViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pinturas")
                    .foregroundStyle(Color.pink)
                    .padding()
                
                ScrollView {
                    if pictureViewModel.isLoading {
                        ProgressView()
                    }
                    else if let errorMessage = pictureViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(Color .red)
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 160))], spacing: 15) {
                            ForEach(pictureViewModel.pictures) { pictures in
                                NavigationLink(destination: PictureDetailView(picture: pictures)) {
                                    PictureRowView(picture: pictures)
                                }
                            }
                        }
                    }
                }
                //.navigationTitle("Pictures")
            }
        }
        .onAppear {
            pictureViewModel.fetchPictures() // Cargar datos al inicio y en el scroll
        }
    }
}


