//
//  Honey.swift
//  Assessment3
//
//  Created by Colton Brenneman on 6/8/23.
//

import Foundation

class Honey: Codable {
    
    var choreName: String
    var choreCount: Int
    var isCompleted: Bool
    let uuid: UUID
    
    init(choreName: String, choreCount: Int, isCompleted: Bool = false, uuid: UUID = UUID()) {
        self.choreName = choreName
        self.choreCount = choreCount
        self.isCompleted = isCompleted
        self.uuid = uuid
    }
} //end of class

// MARK: - Extensions
extension Honey: Equatable {
    static func == (lhs: Honey, rhs: Honey) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
