//
//  ContainerView.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import UIKit

class ContainerView: UIView {
    private var state: ItemState
    
    private lazy var yellowView: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        v.isHidden = true
        return v
    }()
    
    private lazy var blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.isHidden = true
        return v
    }()
    
    private lazy var grayView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    init(state: ItemState) {
        self.state = state
        super.init(frame: .zero)
        backgroundColor = .gray
        setupViewHierarchy()
        setupConstrains()
        updateView(with: state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(yellowView)
        addSubview(blueView)
        addSubview(grayView)
    }
    
    private func setupConstrains() {
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: topAnchor),
            yellowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            yellowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            yellowView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            blueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            blueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
        
        grayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            grayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            grayView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            grayView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    func updateView(with state: ItemState) {
        switch state {
        case .unselected:
            yellowView.isHidden = true
            blueView.isHidden = true
        case .selectedYellow:
            yellowView.isHidden = false
            blueView.isHidden = true
        case .selectedBlue:
            yellowView.isHidden = true
            blueView.isHidden = false
        }
    }
}
