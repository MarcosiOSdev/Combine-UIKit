//
//  ViewController.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 05/09/21.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController {

    private lazy var gasLabel: UILabel = UILabel()
    private lazy var kilometersButton: UIButton = UIButton()
    
    
    var viewModel: CarViewModel = CarViewModel(car: Car())
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Sample"
        view.backgroundColor = UIColor.systemBackground
        setupViews()
        setupLabel()
    }
    
    func setupViews() {
        view.addSubview(gasLabel)
        gasLabel.translatesAutoresizingMaskIntoConstraints = false
        gasLabel.text = "Run .."
        gasLabel.textColor = UIColor.systemGray2
        NSLayoutConstraint.activate([
            gasLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            gasLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gasLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(kilometersButton)
        kilometersButton.translatesAutoresizingMaskIntoConstraints = false
        kilometersButton.setTitle("Drive 10 Kilometers", for: .normal)
        kilometersButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        kilometersButton.isUserInteractionEnabled = true
        kilometersButton.setTitleColor(UIColor.systemBlue, for: .normal)
        
        NSLayoutConstraint.activate([
            kilometersButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            kilometersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupLabel() {
        viewModel
            .batterySubject
            .assign(to: \.text, on: gasLabel)
            .store(in: &cancellables)
    }
    
    @objc
    func didTapButton(_ sender: UIButton) {
        viewModel.drive(kilometers: 10)
    }
    
}

