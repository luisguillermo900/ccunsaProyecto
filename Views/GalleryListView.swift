//
//  GalleryListView.swift
//  ccunsaProyecto
//
//  Created by Gustavo on 17/12/24.
//

import SwiftUI

struct GalleryListView: View {
    @StateObject private var pictureViewModel = PictureViewModel()
    @State private var selectedOption = "Opción 1"
    let options = ["Opción 1", "Opción 2", "Opción 3"]
    
    var body: some View {
        VStack {
            ScrollView {
                if pictureViewModel.isLoading {
                    ProgressView()
                }
                else if let errorMessage = pictureViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color .red)
                } else {
                    /*LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 160))], spacing: 15) {
                        ForEach(pictureViewModel.galleries, id: \.self) { gallery in
                            Button(action: {
                                //selectedGallery = gallery
                            }) {
                                Text(gallery)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }*/
                    VStack {
                        Text("Seleccionado: \(selectedOption)")
                        .font(.headline)
                                
                        Picker("Selecciona una opción", selection: $selectedOption) {
                                ForEach(options, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle()) // Estilo de lista desplegable
                            .padding()
                    }
                    
                    // Mostrar pinturas si una galería está seleccionada
                    /*if let selectedGallery = selectedGallery {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 160))], spacing: 15) {
                            ForEach(pictureViewModel.paintings(for: selectedGallery)) { picture in
                                PictureRowView(picture: picture)
                            }
                        }
                    }*/
                }
                                    
            }
            /*.fullScreenCover(item: $selectedPicture) { picture in
                PictureDetailView(picture: picture, onClose: {
                    selectedPicture = nil
                })
            }              //.navigationTitle("Pictures")*/
        }
        .onAppear {
            pictureViewModel.fetchPictures()  // Llamamos a fetchPictures
        }
        .onChange(of: pictureViewModel.pictures) { _ in
            pictureViewModel.fetchGalleries() // Llamamos a fetchGalleries manualmente cuando pictures cambia
        }
    }
}
