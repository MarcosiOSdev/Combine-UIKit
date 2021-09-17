//
//  CardModel.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 05/09/21.
//

import Foundation

struct CardModel: Hashable, Decodable {
    var id = UUID().uuidString
    let title: String
    let subTitle: String
    let imageName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
