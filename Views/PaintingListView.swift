//
//  PaintingListView.swift
//  ccunsaProyecto
//
//  Created by epismac on 9/10/24.
//

import SwiftUI

struct PaintingListView: View {
    @StateObject private var viewModel = PictureListViewModel()
       let rooms = ["Room1", "Room2", "Room3"] // Lista de habitaciones, puedes cambiarla dinámicamente

       var body: some View {
           VStack {
               Picker("Select Room", selection: $viewModel.selectedRoom) {
                   ForEach(rooms, id: \.self) { room in
                       Text(room)
                   }
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()
               .onChange(of: viewModel.selectedRoom) { _ in
                   viewModel.resetPagination()
               }
               
               List(viewModel.pictures) { picture in
                   NavigationLink(destination: PictureDetailView(picture: picture)) {
                       VStack(alignment: .leading) {
                           HStack {
                               // Tu código existente del HStack
                               AsyncImage(url: URL(string: picture.url)) { image in
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: 100, height: 100)
                                       .clipShape(Circle())
                                       .shadow(radius: 3)
                               } placeholder: {
                                   ProgressView()
                               }
                               VStack (alignment: .leading) {
                                   Text(picture.title).font(.headline)
                                   Text(picture.author).font(.subheadline)
                                   Text(picture.year).font(.footnote).foregroundStyle(Color.blue)
                               }
                           }
                       }
                   }
               }

           }
           
           .onAppear {
               viewModel.selectedRoom = rooms.first ?? ""
               viewModel.resetPagination()
           }
       }
}


