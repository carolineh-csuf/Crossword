//
//  ItemDataModel.swift
//  Crossword
//
//  Created by csuftitan on 4/3/23.
//

import Foundation

enum ItemState {
    case unselected
    case selectedYellow
    case selectedBlue
}

struct ItemDataModel {
    var state: ItemState
    
    init(state: ItemState) {
        self.state = state
    }
}
