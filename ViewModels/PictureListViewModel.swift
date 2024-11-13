//
//  PictureListViewModel.swift
//  ccunsaProyecto
//
//  Created by galaxy on 12/11/24.
//

import Foundation

class PictureListViewModel: ObservableObject {
    @Published var pictures: [Picture] = []
    @Published var selectedRoom: String = ""
    @Published var currentPage: Int = 1
    @Published var hasMorePages: Bool = true

    func fetchPictures() {
        guard !selectedRoom.isEmpty, hasMorePages else { return }

        PictureService.fetchPictures(for: selectedRoom, page: currentPage) { [weak self] result in
            switch result {
            case .success(let pictures):
                DispatchQueue.main.async {
                    if pictures.isEmpty {
                        self?.hasMorePages = false
                    } else {
                        self?.pictures.append(contentsOf: pictures)
                        self?.currentPage += 1
                    }
                }
            case .failure(let error):
                print("Error fetching pictures: \(error)")
            }
        }
    }

    func resetPagination() {
        pictures = []
        currentPage = 1
        hasMorePages = true
        fetchPictures()
    }
}
