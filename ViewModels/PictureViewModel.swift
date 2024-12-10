//
//  PictureViewModel.swift
//  ccunsaProyecto
//
//  Created by galaxy on 30/11/24.
//

import Foundation
import Combine

class PictureViewModel: ObservableObject {

    @Published var pictures: [Pictures] = [] 
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private var repository: DataRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: DataRepository = Repository()) {
        self.repository = repository
        fetchPictures()
    }
    
    func fetchPictures() {
        
        isLoading = true
        errorMessage = nil
        
        repository.fetchPictures()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.errorMessage = "Failed to load data: \(error.localizedDescription)"
                }
            } receiveValue: {
                pictures in self.pictures = pictures
            }
            .store(in: &cancellables)
    }
    func getPictureById(id: Int) -> Pictures? {
        return pictures.first { $0.id == id }
    }
}
