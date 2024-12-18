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
                        /*LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 160))], spacing: 15) {
                            ForEach(pictureViewModel.pictures) { pictures in
                                //NavigationLink(destination: PictureDetailView(picture: pictures)) {
                                    PictureRowView(picture: pictures)
                                    .onTapGesture {
                                        selectedPicture = pictures
                                        isShowingDetail = true
                                    }
                                //}
                            }
                        }*/
                        VStack {
                            ForEach(pictureViewModel.pictures) { pictures in
                            PictureRowView(picture: pictures)
                                .onTapGesture {
                                    selectedPicture = pictures
                                    isShowingDetail = true
                                }
                            }
                        }   
                    }
                }
                /*.fullScreenCover(item: $selectedPicture) { picture in
                    PictureDetailView(picture: picture, onClose: {
                        selectedPicture = nil
                    })
                }              //.navigationTitle("Pictures")*/
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


