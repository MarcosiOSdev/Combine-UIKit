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
    
    func fetch() {
        let models = [
            CardModel(title: "valor 1", subTitle: "valor 1", imageName: "valor 1"),
            CardModel(title: "valor 2", subTitle: "valor 2", imageName: "valor 2"),
            CardModel(title: "valor 3", subTitle: "valor 3", imageName: "valor 3")
        ]
        dataSubject.value += models
    }
    
    func fetchNextPage() {
        currentPage += 1
        let countValues = dataSubject.value.count + 1
        var models: [CardModel] = []
        for i in 0...10 {
            models += [CardModel(title: "valor \( countValues + i) page \(currentPage)", subTitle: "valor \(countValues + i)", imageName: "valor \(countValues + i)")]
        }
        dataSubject.value += models
    }
}
