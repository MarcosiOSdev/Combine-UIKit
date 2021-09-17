//
//  DataProvider.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 05/09/21.
//
import Foundation
import Combine

class DataProvider {
    let dataSubject = CurrentValueSubject<[CardModel], Never>([])
    
    var currentPage = 0
    var cancellables = Set<AnyCancellable>()
    
    func fetchNextPageAsync() {
        let url = URL(string: "https://myserver.com/page/\(currentPage)")!
        currentPage += 1
        
        URLSession.shared.dataTaskPublisher(for: url)
            .sink(receiveCompletion: { _ in
                // handle completion
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                let jsonDecoder = JSONDecoder()
                if let models = try? jsonDecoder.decode([CardModel].self, from: value.data) {
                    self.dataSubject.value += models
                }
            }).store(in: &cancellables)
    }
    
    func fetchNextPage() {
        currentPage += 1
        let models = [CardModel(title: "valor 1", subTitle: "valor 1", imageName: "valor 1")]
        dataSubject.value += models
    }
}
