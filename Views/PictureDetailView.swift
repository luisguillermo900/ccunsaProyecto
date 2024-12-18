//
//  PictureDetailView.swift
//  ccunsaProyecto
//
//  Created by galaxy on 13/11/24.
//

import SwiftUI
import AVFoundation

struct PictureDetailView: View {
    @State private var audioPlayer: AVPlayer?
    @State private var isPlaying = false
    //URL de prueba
    let audioUrl = URL(string: "https://drive.google.com/uc?export=open&id=1MbDInQ5QSSNYU-eYNlUsad_4IWcYYsp9")!
    let picture: Pictures
    var onClose: () -> Void
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                /*Text("Detalles de la pintura con ID: \(id ?? "Desconocido")")
                            .font(.title)
                            .padding()*/
                AsyncImage(url: URL(string: picture.linkImage)) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image): image
                            .resizable()
                            .scaledToFit()  
                            .frame(maxWidth: .infinity)
                            
                    default:
                        ProgressView()
                    }
                }
                .padding(.top, 12.5)
                Text(picture.name)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 12.5)
                    .padding(.bottom, 12.5)
                Text("Sala \(picture.roomId)")
                    .padding(.leading, 20)
                Text("Autor: \(picture.authorId)")
                    .padding(.leading, 20)
                Text("Técnica: \(picture.technique)")
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
                        /*playAudio(from: picture.linkAudio) https://drive.google.com/uc?export=open&id=1MbDInQ5QSSNYU-eYNlUsad_4IWcYYsp9
                        //https://drive.google.com/file/d/1MbDInQ5QSSNYU-eYNlUsad_4IWcYYsp9/view?usp=sharing*/
                        /*playAudio(from: "https://drive.google.com/uc?export=open&id=1MbDInQ5QSSNYU-eYNlUsad_4IWcYYsp9")*/
                        playAudio()
                    }) {
                        Image(systemName: "play.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                    Button(action: {
                        // Acción del botón
                        print("Botón de pause presionado")
                        pauseAudio()
                    }) {
                        Image(systemName: "pause.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                    Button(action: {
                        // Acción del botón
                        print("Botón de stop presionado")
                        stopAudio()
                    }) {
                        Image(systemName: "stop.circle")
                            .font(.largeTitle) // Ajusta el tamaño del icono
                            .foregroundColor(.black) // Cambia el color del icono
                    }
                }
                Text(picture.description)
            }
            
            .padding(.horizontal, 25)
            .navigationBarTitle("", displayMode: .inline)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            .edgesIgnoringSafeArea(.all)
            //.navigationBarHidden(true)
            Spacer()
            //.frame(maxHeight: .infinity)
        }
        .onAppear {
            prepareAudio()
        }
    }
    func prepareAudio() {
        audioPlayer = AVPlayer(url: audioUrl)
    }
    func playAudio() {
        audioPlayer?.play()
        isPlaying = true
    }
        
    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }
        
    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer?.seek(to: .zero) // Reinicia al inicio
        isPlaying = false
    }
}

extension Color {
    static let customLighBlue = Color(red: 80 / 255.0, green: 140 / 255.0, blue: 155 / 255.0)
    static let customBlue = Color(red: 19 / 255.0, green: 75 / 255.0, blue: 112 / 255.0)
    static let customLightGray = Color(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0)
    static let customDarkGray = Color(red: 23 / 255.0, green: 23 / 255.0, blue: 22 / 255.0)
    static let customGolden = Color(red: 235 / 255.0, green: 179 / 255.0, blue: 1 / 255.0)
}


