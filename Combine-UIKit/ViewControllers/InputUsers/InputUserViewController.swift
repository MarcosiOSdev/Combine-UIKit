//
//  InputUserViewController.swift
//  Combine-UIKit
//
//  Created by marcos.felipe.souza on 29/09/21.
//

import Combine
import UIKit

class InputUserViewController: UIViewController {
    
    let slider = UISlider()
    let label = UILabel()
    
//    var sliderValue: Float = 50 {
//        didSet {
//            slider.value = sliderValue
//            label.text = "Slider is at \(sliderValue)"
//        }
//    }
    
    @Published
    var sliderValue: Float = 50
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBackground
        setupSlider()
        setupLabel()
        
        $sliderValue
            .map({ "Slider is at \($0)" })
            .assign(to: \.text, on: label)
            .store(in: &cancellables)
        
        $sliderValue
            .assign(to: \.value, on: slider)
            .store(in: &cancellables)
    }
    
    private func setupSlider(){
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        slider.addTarget(self, action: #selector(updateLabel), for: .valueChanged)
    }
    
    @objc
    private func updateLabel() {
        sliderValue = slider.value
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
