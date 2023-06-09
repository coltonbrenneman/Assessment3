//
//  HoneyController.swift
//  Assessment3
//
//  Created by Colton Brenneman on 6/8/23.
//

import Foundation

class HoneyController {
    
    // MARK: - Properties
    static let sharedInstance = HoneyController()
    var honeys: [Honey] = []
    
    init() {
        load()
    }
    // MARK: - Functions
    func createHoney(choreName: String, choreCount: Int) {
        let honey = Honey(choreName: choreName, choreCount: choreCount)
        honeys.append(honey)
        save()
    }
    
    func deleteHoney(honey: Honey) {
        guard let index = honeys.firstIndex(of: honey) else { return }
        honeys.remove(at: index)
        save()
    }
    
    func toggleIsTapped(honey: Honey) {
        honey.isCompleted.toggle()
        save()
    }
    
    func toggleAllCompleted() {
        honeys.forEach { $0.isCompleted = true }
        save()
    }
    
    func toggleAllUncompleted() {
        honeys.forEach { $0.isCompleted = false }
        save()
    }
    
    // MARK: - Persistence
    func save() {
        guard let url = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(honeys)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }

    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let honeys = try JSONDecoder().decode([Honey].self, from: data)
            self.honeys = honeys
        } catch {
            print(error)
        }
    }

    private var fileURL: URL? {
        guard let documentsDirector = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirector.appendingPathComponent("honeys.json")
        return url
    }
}//end of class
