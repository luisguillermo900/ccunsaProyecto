//
//  GalleryListView.swift
//  ccunsaProyecto
//
//  Created by Gustavo on 17/12/24.
//

import SwiftUI

struct GalleryListView: View {
    @StateObject private var pictureViewModel = PictureViewModel()
    @State var selection1: String? = nil
    @State var selectedGalleryId: Int? = nil
    
    var body: some View {
        VStack {
            DropDownPicker(
                selectedGalleryId: $selectedGalleryId,
                options: pictureViewModel.galleries
            )
            .padding(.bottom, 10)
            .padding(.horizontal, 15)
            ScrollView {
                PaintingListView()
            }
        }
        .onAppear {
            pictureViewModel.fetchPictures()
        }
        .onChange(of: pictureViewModel.pictures) { _ in
            pictureViewModel.fetchGalleries()
        }
    }
}

enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownPicker: View {
    
    @State var selection: String?
    @Binding var selectedGalleryId: Int?
    var state: DropDownPickerState = .bottom
    var options: [GalleryOption]
    var maxWidth: CGFloat = 180
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                if state == .top && showDropdown {
                    OptionsView()
                }
                HStack {
                    Text(selection == nil ? "Select" : selection!)
                        .foregroundColor(selection != nil ? .black : .gray)
                    Spacer(minLength: 0)
                    
                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
                .padding(.horizontal, 15)
                //.frame(width: 180, height: 50)
                .frame(height: 50)
                .background(.white)
                .contentShape(Rectangle())
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.linear) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(.white)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
            
        }
        //.frame(width: maxWidth, height: 50)
        .frame(height: 50)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option.name)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option.name ? 1 : 0)
                }
                .foregroundStyle(selection == option.name ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(Rectangle())
                .padding(.horizontal, 15)
                .onTapGesture {
                    withAnimation(.linear) {
                        selection = option.name
                        selectedGalleryId = option.id
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}
