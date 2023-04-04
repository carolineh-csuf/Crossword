//
//  PromptView.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import UIKit

protocol PromptViewDelegate: AnyObject {
    func directionDidChange(view: PromptView)
    func leftButtonDidTap(view: PromptView)
    func rightButtonDidTap(view: PromptView)
}

class PromptView: UIView {
    enum Direction {
        case horizontal
        case vertical
    }
    
    weak var delegate: PromptViewDelegate?
    
    var direction: Direction {
        didSet {
            updateDirectionDescription()
            delegate?.directionDidChange(view: self)
        }
    }
    
    private lazy var leftButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .green
        b.addTarget(self, action: #selector(leftButtonOnTap), for: .touchUpInside)
        b.setTitle("Previous", for: .normal)
        return b
    }()
    
    private lazy var middleButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .orange
        b.titleLabel?.numberOfLines = 0
        b.addTarget(self, action: #selector(middleButtonOnTap), for: .touchUpInside)
        return b
    }()
    
    private lazy var rightButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .cyan
        b.addTarget(self, action: #selector(rightButtonOnTap), for: .touchUpInside)
        b.setTitle("next", for: .normal)
        return b
    }()
    
    init() {
        direction = .horizontal
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstrains()
        updateDirectionDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        addSubview(leftButton)
        addSubview(middleButton)
        addSubview(rightButton)
    }
    
    private func setupConstrains() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topAnchor),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftButton.widthAnchor.constraint(equalTo: leftButton.heightAnchor)
        ])
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor)
        ])
        
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleButton.topAnchor.constraint(equalTo: topAnchor),
            middleButton.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor),
            middleButton.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            middleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func updateDirectionDescription() {
        middleButton.setTitle(direction == .horizontal ? "horizontal" : "vertical", for: .normal)
    }
    
    @objc private func middleButtonOnTap() {
        if direction == .horizontal {
            direction = .vertical
        } else {
            direction = .horizontal
        }
    }
    
    @objc private func leftButtonOnTap() {
        delegate?.leftButtonDidTap(view: self)
    }
    
    @objc private func rightButtonOnTap() {
        delegate?.rightButtonDidTap(view: self)
    }
}
