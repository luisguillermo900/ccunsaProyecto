//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    @StateObject private var pictureViewModel = PictureViewModel()
    @State private var selectedPicture: Pictures?
    
    //Provisional
    @State private var isShowingDetail = false
    
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
                        VStack {
                            ForEach(pictureViewModel.pictures) { pictures in
                            PictureRowView(picture: pictures)
                                .onTapGesture {
                                    selectedPicture = pictures
                                    isShowingDetail = true
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                }
            }
            .onAppear {
                pictureViewModel.fetchPictures() // Cargar datos al inicio y en el scroll
            }
            .background(
                Group {
                    if let picture = selectedPicture {
                        NavigationLink(
                            destination: PictureDetailView(picture: picture, onClose: {
                                isShowingDetail = false
                                selectedPicture = nil
                            }),
                            isActive: $isShowingDetail,
                            label: { EmptyView() }
                        )
                    }
                }
            )
        
        
    }
}


