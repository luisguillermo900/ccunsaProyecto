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
    @Published var galleries: [String] = []
    
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
    func fetchGalleries(){
        if !pictures.isEmpty {
            galleries = Array(Set(pictures.map { "Galería \($0.roomId.toRoman)"})).sorted()
            print("Galerías cargadas: \(galleries)")  // Verificar si las galerías están siendo cargadas
        } else {
            print("No hay pinturas cargadas aún.")
        }
    }
    func getPictureById(id: Int) -> Pictures? {
        return pictures.first { $0.id == id }
    }
}

extension Int {
    var toRoman: String {
        let romanValues = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
            (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        ]
        
        var number = self
        var result = ""
        
        for (value, roman) in romanValues {
            while number >= value {
                result += roman
                number -= value
            }
        }
        
        return result
    }
}
