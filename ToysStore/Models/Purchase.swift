//
//  Purchase.swift
//  ToysStore
//
//  购买相关数据模型和业务逻辑
//

import Foundation
import SwiftData

@Model
class PurchaseRecord {
    var id: UUID
    var toyName: String
    var toyEmoji: String
    var price: Double
    var purchaseDate: Date

    init(toyName: String, toyEmoji: String, price: Double, purchaseDate: Date = Date()) {
        self.id = UUID()
        self.toyName = toyName
        self.toyEmoji = toyEmoji
        self.price = price
        self.purchaseDate = purchaseDate
    }
}

struct RecordsGroup: Identifiable {
    var id: String { toyName }
    let toyName: String
    let toyEmoji: String
    let unitPrice: Double
    let quantity: Int

    var subtotal: Double {
        unitPrice * Double(quantity)
    }
}

struct PurchaseManager {
    let records: [PurchaseRecord]

    init(purchaseRecords: [PurchaseRecord]) {
        self.records = purchaseRecords
    }

    var groupedPurchases: [RecordsGroup] {
        let grouped = Dictionary(grouping: records) { $0.toyName }
        return grouped.map { (name, records) in
            RecordsGroup(
                toyName: name,
                toyEmoji: records.first?.toyEmoji ?? "🎁",
                unitPrice: records.first?.price ?? 0,
                quantity: records.count
            )
        }.sorted { $0.toyName < $1.toyName }
    }

    var totalAmount: Double {
        groupedPurchases.reduce(0) { $0 + $1.subtotal }
    }

    var totalPriceString: String {
        totalAmount.toPriceString()
    }

    var recordCount: Int {
        records.count
    }

    var isEmpty: Bool {
        records.isEmpty
    }
}
