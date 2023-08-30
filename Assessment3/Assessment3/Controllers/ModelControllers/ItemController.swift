//
//  ItemController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import Foundation

class ItemController {
    
    // MARK: - CRUD
    static func createItem(newItemName: String, honey: Honey) {
        let newItem = Item(itemName: newItemName)
        honey.honeyItem.append(newItem)
        
        ChoreController.shared.save()
    } // End of createItem
    
    static func deleteItem(itemToBeDelted: Item, honey: Honey) {
        guard let itemIndex = honey.honeyItem.firstIndex(of: itemToBeDelted) else { return }
        honey.honeyItem.remove(at: itemIndex)
        
        ChoreController.shared.save()
    } // End of deleteItem
    
    // MARK: - Function
    static func toggleItemIsCompleted(item: Item) {
        item.itemCompleted.toggle()
        
        ChoreController.shared.save()
    } // End of toggleItemIsCompleted
    
    static func clearAllItems(honey: Honey) {
        honey.honeyItem.removeAll()
        
        ChoreController.shared.save()
    } // End of clearAllItems
    
} // End of class
