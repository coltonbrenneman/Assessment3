//
//  Item.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import Foundation

class Item: Codable {
    
    let itemName: String
    var itemCompleted: Bool
    let itemUUID: UUID
    
    init(itemName: String, itemCompleted: Bool = false, itemUUID: UUID = UUID()) {
        self.itemName = itemName
        self.itemCompleted = itemCompleted
        self.itemUUID = itemUUID
    }
} // End of class

// MARK: - Extension
extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.itemUUID == rhs.itemUUID
    }
} // End of extension
