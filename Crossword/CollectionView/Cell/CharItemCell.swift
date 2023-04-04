//
//  CharItemCell.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import UIKit

class CharItemCell: UICollectionViewCell {
    private lazy var containerView: ContainerView = {
        let v = ContainerView(state: .unselected)
//        v.backgroundColor = .randomColor
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellComponent() {
        addSubview(containerView)
        containerView.frame = bounds
    }
    
    func configCell(with dataModel: ItemDataModel) {
        containerView.updateView(with: dataModel.state)
    }
}
