//
//  FrequencyUserInput.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 29/09/21.
//

import UIKit
import Combine

class FrequencyUserInputViewController: UIViewController {
    
    let textField = UITextField()
    let label = UILabel()
    
    @Published
    var searchQuery: String?
    
    var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        setupUI()
        $searchQuery
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .filter({ ($0 ?? "").count > 3 })
            .removeDuplicates()
            .print()
            .assign(to: \.text, on: label)
            .store(in: &cancellables)
    }
    
    @objc
    private func textChanged() {
        searchQuery = textField.text
    }
    
    
    
    
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(textField)
        view.addSubview(label)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.becomeFirstResponder()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 36),
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
        ])
    }
}

