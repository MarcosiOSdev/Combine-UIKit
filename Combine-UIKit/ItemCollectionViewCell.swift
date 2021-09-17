//
//  ItemCollectionViewCell.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 05/09/21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ItemCollectionViewCell"
    
    var textInput: String? {
        didSet {
            textLabel.text = textInput
        }
    }
    
    var isHeader: Bool = false {
        didSet {
            if isHeader {
                textLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
                contentView.backgroundColor = .clear
            }
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "No title"
        label.textColor = UIColor.systemBlue
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabel() {
        contentView.backgroundColor = UIColor.systemBackground
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
