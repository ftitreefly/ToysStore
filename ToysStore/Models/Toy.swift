//
//  Toy.swift
//  ToysStore
//
//  玩具数据模型
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Toy {
    var id: UUID
    var name: String
    var toyDescription: String
    var price: Double
    var isPremium: Bool
    var emoji: String

    init(name: String, description: String, price: Double, isPremium: Bool, emoji: String) {
        self.id = UUID()
        self.name = name
        self.toyDescription = description
        self.price = price
        self.isPremium = isPremium
        self.emoji = emoji
    }
}
