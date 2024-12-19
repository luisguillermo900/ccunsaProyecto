//
//  PictureRowView.swift
//  ccunsaProyecto
//
//  Created by galaxy on 30/11/24.
//

import SwiftUI

struct PictureRowView: View {
    
    let picture: Pictures
    
    var body: some View {
        /*VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: picture.linkImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .bottom) {
                            Text(picture.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .shadow(color: .black ,radius: 3, x: 0, y: 0)
                                .frame(maxWidth: 136)
                                .padding()
                        }
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment:  .center)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .frame(width: 160 ,height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)*/
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: picture.linkImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Mantiene la relación
                        .frame(width: 150, height: 150)
                        //.padding(.horizontal, 4)
                        .padding(.leading, 6)
                        .padding(.vertical, 4)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment:  .center)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                VStack{
                    Text(picture.name)
                    .bold()
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(picture.authorId)")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text(picture.technique)
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 15)
            }
        }
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}


