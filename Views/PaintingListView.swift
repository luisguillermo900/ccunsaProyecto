//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    @State private var selectedGallery: String = "Galería 1"
    let galleries = ["Galería 1", "Galería 2", "Galería 3"] // Lista de galerías

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Lista de Pinturas en Exposición")
                .font(.largeTitle)
                .padding()
            
            // Picker para seleccionar la galería
            Picker("Selecciona una galería", selection: $selectedGallery) {
                ForEach(galleries, id: \.self) { gallery in
                    Text(gallery).tag(gallery) // Cada opción del Picker
                }
            }
            .pickerStyle(MenuPickerStyle()) // cambiar el estilo del Picker
            .padding()

            // Lista para el conjunto de pinturas
            List {
                ForEach(0..<10) { index in
                    Text("Pintura \(index + 1) en \(selectedGallery)")
                }
            }
            Spacer()
        }
        .navigationTitle("Pinturas")
        .padding()
    }
}


