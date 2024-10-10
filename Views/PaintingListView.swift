//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Lista de Pinturas en Exposición")
                .font(.largeTitle)
                .padding()

            // List par el conjunto de pinturas
            List {
                ForEach(0..<10) { index in
                    Text("Pintura \(index + 1)")
                }
            }
            Spacer()
        }
        .navigationTitle("Pinturas")
        .padding()
    }
}


