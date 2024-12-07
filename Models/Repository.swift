//
//  Repository.swift
//  ccunsaProyecto
//
//  Created by galaxy on 2/12/24.
//

import Foundation
import Combine

protocol DataRepository {
    var url: URL { get }
}

// Añade esta funcion a DataRepository
extension DataRepository {
    func fetchPictures() -> AnyPublisher<[Pictures], Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PicturesDTO].self, decoder: decoder)
            .map { $0.map { $0.toPicture } }
            .eraseToAnyPublisher()
    }
}

struct Repository: DataRepository {
    var url: URL {
        URL(string: "https://ccunsa-77a2c-default-rtdb.firebaseio.com/ccunsa/pictures.json")!
    }
}

// ? -> valor o nil,
// ! -> hay si o si un valor
