//
//  DinosaurModel.swift
//  DinosaurInfo
//
//  Created by Akshat Gandhi on 05/11/25.
//

import Foundation
import SwiftUI

struct DinosaurModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: DinosaurType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum DinosaurType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: DinosaurType {
        self
    }
    var backgroundColor: Color {
        switch self {
        case .land:  .brown
        case .air:  .teal
        case .sea: .blue
        case .all: .gray
        }
    }
    
    var icon: String {
        switch self {
        case .land:  "leaf.fill"
        case .air:  "wind"
        case .sea: "water.waves"
        case .all: "square.stack.3d.up.fill"
        }
    }
}
