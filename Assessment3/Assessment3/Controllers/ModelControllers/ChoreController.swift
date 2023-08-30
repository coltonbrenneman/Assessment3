//
//  ChoreController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 8/30/23.
//

import Foundation

class ChoreController {
    
    // MARK: - Properties
    static let shared = ChoreController()
    var honey: [Honey] = []
    init() {
        load()
    }
    
    // MARK: - CRUD
    func createHoney(name: String, honeyItem: [Item] = []) {
        let newHoney = Honey(honeyName: name)
        honey.append(newHoney)
        save()
    } // End of createHoney
    
    func deleteHoney(honeyToRemove: Honey) {
        guard let honeyIndex = honey.firstIndex(of: honeyToRemove) else { return }
        honey.remove(at: honeyIndex)
        save()
    } // End of deleteHoney
    
    // MARK: - Functions
    func toggleHoneyIsCompleted(honey: Honey) {
        honey.honeyCompleted.toggle()
        save()
    } //toggleHoneyIsCompleted
    
    // MARK: - Persistence
    func save() {
        guard let url = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(honey)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let honey = try JSONDecoder().decode([Honey].self, from: data)
            self.honey = honey
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirector = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirector.appendingPathComponent("honey.json")
        return url
    }
    
    
} // End of class
