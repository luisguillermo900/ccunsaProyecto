//
//  Picture.swift
//  ccunsaProyecto
//
//  Created by galaxy on 12/11/24.
//

import Foundation

// struct Picture: Identifiable, Decodable {
struct Picture: Identifiable, Codable {
    let id: Int
    let title: String
    let author: String
    let room: String
    let technique: String
    let category: String
    let description: String
    let year: String
    let url: String
}

// Data Transfer Object - Datos a cargar
struct PicturesDTO: Codable {
    let id: Int
    let authorId: Int
    let roomId: Int
    let name: String
    let technique: String
    let category: String
    let description: String
    let year: String
    let linkImage: String
    let linkQr: String
    let linkAudio: String
    let posX: Int
    let posY: Int
}

// Transformar de datos obtenidos en datos devueltos
extension PicturesDTO {
    // Propiedad calculada
    var toPicture: Pictures {
        Pictures(id: id,
                 authorId: authorId,
                 roomId: roomId,
                 name: name,
                 technique: technique,
                 category: category,
                 description: description,
                 year: year,
                 linkImage: linkImage,
                 linkQr: linkQr,
                 linkAudio: linkAudio,
                 posX: posX,
                 posY: posY)
    }
}

// Datos devueltos para mostar en swiftui
struct Pictures: Identifiable, Hashable {
    let id: Int
    let authorId: Int
    let roomId: Int
    let name: String
    let technique: String
    let category: String
    let description: String
    let year: String
    let linkImage: String
    let linkQr: String
    let linkAudio: String
    let posX: Int
    let posY: Int
}
