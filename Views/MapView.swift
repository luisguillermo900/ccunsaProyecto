//
//  MapView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack {
            Text("Mapa de la Galería")
                .font(.largeTitle)
                .padding()

            // Mapa
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 300)
                .overlay(Text("Mapa aquí").foregroundColor(.white))
            Spacer()
        }
        .navigationTitle("Mapa")
        .padding()
    }
}



