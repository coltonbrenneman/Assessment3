//
//  Honey.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import Foundation

class Honey: Codable {
    
    let honeyName: String
    var honeyItem: [Item]
    var honeyCompleted: Bool
    let honeyUUID: UUID
    
    init(honeyName: String, honeyItem: [Item] = [], honeyCompleted: Bool = false, honeyUUID: UUID = UUID()) {
        self.honeyName = honeyName
        self.honeyItem = honeyItem
        self.honeyCompleted = honeyCompleted
        self.honeyUUID = honeyUUID
    }
} // End of class

// MARK: - Extension
extension Honey: Equatable {
    static func == (lhs: Honey, rhs: Honey) -> Bool {
        return lhs.honeyUUID == rhs.honeyUUID
    }
} // End of extension
