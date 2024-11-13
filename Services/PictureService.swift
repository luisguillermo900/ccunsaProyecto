//
//  PictureService.swift
//  ccunsaProyecto
//
//  Created by galaxy on 12/11/24.
//

import Foundation

class PictureService {
    static func fetchPictures(for room: String, page: Int, completion: @escaping (Result<[Picture], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.1.2:3001/api/ccunsa/pictures?room=\(room)&page=\(page)") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }

            do {
                let pictures = try JSONDecoder().decode([Picture].self, from: data)
                completion(.success(pictures))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

