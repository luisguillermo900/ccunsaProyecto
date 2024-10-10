//
//  QRScannerView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct QRScannerView: View {
    var body: some View {
        VStack {
            Text("Escanear QR")
                .font(.largeTitle)
                .padding()

            // QR
            Rectangle()
                .fill(Color.gray)
                .frame(height: 300)
                .overlay(Text("Escáner aquí").foregroundColor(.white))
            Spacer()
        }
        .navigationTitle("Escanear")
        .padding()
    }
}



