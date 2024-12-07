//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    
    @StateObject private var pictureViewModel = PictureViewModel()
    @State private var selectedPicture: Pictures?
    
    var body: some View {
        NavigationView {
            VStack {
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
                                //NavigationLink(destination: PictureDetailView(picture: pictures)) {
                                    PictureRowView(picture: pictures)
                                    .onTapGesture {
                                        selectedPicture = pictures
                                    }
                                //}
                            }
                        }
                    }
                }
                .fullScreenCover(item: $selectedPicture) { picture in
                    PictureDetailView(picture: picture, onClose: {
                        selectedPicture = nil
                    })
                }              //.navigationTitle("Pictures")
            }
        }
        .onAppear {
            pictureViewModel.fetchPictures() // Cargar datos al inicio y en el scroll
        }
    }
}


