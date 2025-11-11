//
//  Predators.swift
//  DinosaurInfo
//
//  Created by Akshat Gandhi on 05/11/25.
//

import Foundation

class Predators {
    var allApexPredators: [DinosaurModel] = []
    var apexPredators: [DinosaurModel] = []
    
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        guard let fileURL = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            allApexPredators = try decoder.decode([DinosaurModel].self, from: data)
            apexPredators = allApexPredators
        } catch {
            print("Error decoding JSON data: \(error)")
        }
    }
    
    func search(for searchTerm: String) -> [DinosaurModel] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { p1, p2 in
            if alphabetical {
                p1.name.lowercased() < p2.name.lowercased()
            } else {
                p1.id < p2.id
            }
        }
    }
    
    func filter(by type: DinosaurType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { $0.type == type}
        }
    }
}
