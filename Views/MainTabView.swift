//
//  MainiTabView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedin: Bool
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, paintingList, map, qrScanner
    }

    var body: some View {
        NavigationView {
            VStack {
                // botón de logout
                /*HStack {
                    Spacer()
                    Button(action: {
                        isLoggedin = false // Logout
                    }) {
                        Image(systemName: "arrow.right.circle") // Icono de logout
                            .font(.title)
                            .foregroundColor(.red)
                    }
                    .padding()
                }*/
                Spacer() // Para empujar el contenido hacia arriba

                switch selectedTab {
                case .home:
                    HomeView()
                case .paintingList:
                    ArtView()
                    //PaintingListView()
                case .map:
                    MapView()	
                case .qrScanner:
                    QRScannerView()
                }

                // Botones de navegación en la parte inferior
                HStack {
                    Button(action: { selectedTab = .home }) {
                        Image(systemName: "house")
                            .font(.title)
                            .foregroundColor(selectedTab == .home ? .blue : .gray) // Cambia el color
                            .padding()
                            .background(selectedTab == .home ? Color.blue.opacity(0.2) : Color.clear) // Sombreado
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button(action: { selectedTab = .paintingList }) {
                        Image(systemName: "paintpalette")
                            .font(.title)
                            .foregroundColor(selectedTab == .paintingList ? .blue : .gray)
                            .padding()
                            .background(selectedTab == .paintingList ? Color.blue.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button(action: { selectedTab = .map }) {
                        Image(systemName: "map")
                            .font(.title)
                            .foregroundColor(selectedTab == .map ? .blue : .gray)
                            .padding()
                            .background(selectedTab == .map ? Color.blue.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button(action: { selectedTab = .qrScanner }) {
                        Image(systemName: "qrcode")
                            .font(.title)
                            .foregroundColor(selectedTab == .qrScanner ? .blue : .gray)
                            .padding()
                            .background(selectedTab == .qrScanner ? Color.blue.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
            .navigationTitle("Galería")
            .navigationBarItems(
                trailing: Button(action: {
                    isLoggedin = false // Logout
                }) {
                    Image(systemName: "arrow.right.circle") // Icono de logout
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(.top, 8) // Ajusta el padding superior
                        .offset(y: 40)
                }
            )
        }
    }
}




