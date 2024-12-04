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
            // ScrollView para permitir desplazamiento
            ScrollView {
                // Canvas para dibujar el mapa
                Canvas { context, size in
                    // Tamaño objetivo para escalar
                    let targetWidth: CGFloat = 360
                    let targetHeight: CGFloat = 720
                    
                    // Factor de escala (ajustado a 360x720)
                    let scaleFactorX: CGFloat = targetWidth / 1025
                    let scaleFactorY: CGFloat = targetHeight / 2060
                    
                    // Lista de rectángulos con etiquetas
                    let rectangulos: [(CGRect, String)] = [
                        (CGRect(x: 0, y: 0, width: 228, height: 317), "Admin"),
                        (CGRect(x: 772, y: 0, width: 253, height: 317), "Baños"),
                        (CGRect(x: 228, y: 317, width: 431, height: 317), "Sala 7"),
                        (CGRect(x: 0, y: 317, width: 228, height: 634), "Sala 6"),
                        (CGRect(x: 228, y: 1109, width: 431, height: 317), "Sala 5"),
                        (CGRect(x: 0, y: 1109, width: 228, height: 317), "Sala 4"),
                        (CGRect(x: 0, y: 1426, width: 228, height: 317), "Sala 3"),
                        (CGRect(x: 0, y: 1743, width: 228, height: 317), "Sala 2"),
                        (CGRect(x: 228, y: 1743, width: 431, height: 317), "Sala 1"),
                        (CGRect(x: 772, y: 317, width: 253, height: 317), "Admin"),
                        (CGRect(x: 772, y: 634, width: 253, height: 475), "Libre"),
                        (CGRect(x: 772, y: 1109, width: 253, height: 317), "Sala 8"),
                        (CGRect(x: 772, y: 1426, width: 253, height: 317), "Sala 9"),
                        (CGRect(x: 772, y: 1743, width: 253, height: 317), "Sala 10")
                    ]
                    
                    // Dibuja cada rectángulo escalado
                    for (rect, label) in rectangulos {
                        // Aplicar el factor de escala a cada rectángulo
                        let scaledRect = CGRect(
                            x: rect.origin.x * scaleFactorX,
                            y: rect.origin.y * scaleFactorY,
                            width: rect.size.width * scaleFactorX,
                            height: rect.size.height * scaleFactorY
                        )
                        
                        let path = Path(scaledRect)
                        context.stroke(path, with: .color(.blue), lineWidth: 2)
                        
                        // Posicionar el texto centrado dentro del rectángulo escalado
                        let textPosition = CGPoint(x: scaledRect.midX, y: scaledRect.midY)
                        context.draw(Text(label).foregroundColor(.black), at: textPosition)
                    }
                }
                .frame(width: 360, height: 720)
                .border(Color.blue, width: 4) // Borde alrededor del mapa
            }

            
        }
        .navigationTitle("Mapa")
        .padding()
    }
}



