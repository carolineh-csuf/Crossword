//
//  GridFlowLayout.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        let width = (collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns)
        itemSize = CGSize(width: width, height: width)
    }

    private var numberOfColumns: Int = 10

    convenience init(numberOfColumns: Int) {
        self.init()
        self.numberOfColumns = numberOfColumns
    }
}
