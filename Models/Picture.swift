//
//  Picture.swift
//  ccunsaProyecto
//
//  Created by galaxy on 12/11/24.
//

import Foundation

struct Picture: Identifiable, Decodable {
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
