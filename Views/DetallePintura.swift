//
//  DetallePintura.swift
//  ccunsaProyecto
//
//  Created by Gustavo on 11/11/24.
//

import SwiftUI

struct DetallePintura: View {
    let id: String?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                /*Text("Detalles de la pintura con ID: \(id ?? "Desconocido")")
                            .font(.title)
                            .padding()*/
                AsyncImage(url: URL(string: "https://centrocultural.unsa.edu.pe/wp-content/uploads/2024/06/164.jpg")) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image): image
                            .resizable()
                            .scaledToFit()  // Ajusta la imagen para que llene el ancho y mantenga la proporción
                            .frame(maxWidth: .infinity)
                            
                    default:
                        ProgressView()
                    }
                }
                .padding(.top, 12.5)
                Text("Copa id: \(id ?? "Desconocido")")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 12.5)
                    .padding(.bottom, 12.5)
                Text("Sala 1")
                    .padding(.leading, 20)
                Text("Maurico Álvarez Ambroncio")
                    .padding(.leading, 20)
                Text("Técnica:")
                    .padding(.leading, 20)
                    .padding(.bottom, 12.5)
                Divider()
                    .frame(minHeight: 2)
                    .overlay(Color.gray)
                HStack(){
                    Text("Descripcion")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.top, 12.5)
                        .padding(.bottom, 12.5)
                    Spacer()
                    Button(action: {
                        // Acción del botón
                        print("Botón de play presionado")
                    }) {
                        Image(systemName: "play.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                    Button(action: {
                        // Acción del botón
                        print("Botón de pause presionado")
                    }) {
                        Image(systemName: "pause.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                    Button(action: {
                        // Acción del botón
                        print("Botón de stop presionado")
                    }) {
                        Image(systemName: "stop.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                }
                Text("Los callejones olvidados, intersticios urbanos, mezzanines y espacios abandonados por la vida son una realidad paralela que cohabita con el deterioro social de la apreciación de lo mundano.")
            }
            .padding(.horizontal, 25)
            .navigationBarTitle("", displayMode: .inline)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            //.navigationBarHidden(true)
        Spacer()
            
            //.frame(maxHeight: .infinity)
        }
    }
}
