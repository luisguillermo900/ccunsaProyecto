//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @Binding var galleryId: Int
    @StateObject private var pictureViewModel = PictureViewModel()
    @State private var filteredPictures: [Pictures] = []
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
                        if(galleryId == 0){
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
                        } else if (galleryId > 0) {
                            VStack {
                                ForEach(filteredPictures) { pictures in
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
            }
            .onAppear {
                if pictureViewModel.pictures.isEmpty {
                    pictureViewModel.fetchPictures()
                }
            }
            .onChange(of: pictureViewModel.pictures) { _ in
                if galleryId > 0 {
                    filteredPictures = pictureViewModel.filterPicturesByGallery(galleryId: galleryId)
                }
            }
            .onChange(of: galleryId) { _ in
                if galleryId > 0 {
                    filteredPictures = pictureViewModel.filterPicturesByGallery(galleryId: galleryId)
                }
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


