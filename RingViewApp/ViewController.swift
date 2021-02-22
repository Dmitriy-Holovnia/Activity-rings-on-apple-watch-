//
//  ViewController.swift
//  RingViewApp
//
//  Created by cr3w on 22.02.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupRings()
    }
    
    private func setupRings() {
        let ring1 = RingView(frame: .init(x: 0, y: 0, width: 200, height: 200),
                             value: 0.5,
                             color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        let ring2 = RingView(frame: .init(x: 0, y: 0, width: 160, height: 160),
                             value: 0.9,
                             color: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
        let ring3 = RingView(frame: .init(x: 0, y: 0, width: 120, height: 120),
                             value: 0.7,
                             color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
        
        
        [ring1, ring2, ring3].forEach { ring in
            ring.center = view.center
            view.addSubview(ring)
        }
    }
    
    
}

