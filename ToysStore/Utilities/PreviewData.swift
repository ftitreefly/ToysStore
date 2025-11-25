//
//  PreviewData.swift
//  ToysStore
//
//  Preview 测试数据扩展
//

import Foundation
import SwiftData

#if DEBUG

// MARK: - Toy 测试数据

extension Toy {
    /// 示例普通玩具
    static var sampleRegular: [Toy] {
        [
            Toy(name: "积木", description: "经典彩色积木，培养创造力", price: 29.99, isPremium: false, emoji: "🧱"),
            Toy(name: "毛绒熊", description: "可爱的泰迪熊，陪伴成长", price: 49.99, isPremium: false, emoji: "🧸"),
            Toy(name: "拼图", description: "100片拼图，锻炼专注力", price: 19.99, isPremium: false, emoji: "🧩"),
            Toy(name: "彩色画笔", description: "24色水彩画笔套装", price: 39.99, isPremium: false, emoji: "🖍️")
        ]
    }

    /// 示例高级玩具
    static var samplePremium: [Toy] {
        [
            Toy(name: "智能机器人", description: "AI智能机器人，对话互动", price: 299.99, isPremium: true, emoji: "🤖"),
            Toy(name: "无人机", description: "4K航拍无人机，探索天空", price: 599.99, isPremium: true, emoji: "🚁"),
            Toy(name: "VR眼镜", description: "虚拟现实体验设备", price: 399.99, isPremium: true, emoji: "🥽")
        ]
    }

    /// 所有示例玩具
    static var allSamples: [Toy] {
        sampleRegular + samplePremium
    }
}

// MARK: - PurchaseRecord 测试数据

extension PurchaseRecord {
    /// 示例购买记录
    static var samples: [PurchaseRecord] {
        [
            PurchaseRecord(toyName: "积木", toyEmoji: "🧱", price: 29.99),
            PurchaseRecord(toyName: "积木", toyEmoji: "🧱", price: 29.99),
            PurchaseRecord(toyName: "毛绒熊", toyEmoji: "🧸", price: 49.99),
            PurchaseRecord(toyName: "拼图", toyEmoji: "🧩", price: 19.99),
            PurchaseRecord(toyName: "彩色画笔", toyEmoji: "🖍️", price: 39.99),
            PurchaseRecord(toyName: "毛绒熊", toyEmoji: "🧸", price: 49.99),
            PurchaseRecord(toyName: "拼图", toyEmoji: "🧩", price: 19.99)
        ]
    }
}

// MARK: - PurchaseManager 测试数据

extension PurchaseManager {
    /// 示例管理器（包含测试数据）
    static var sample: PurchaseManager {
        PurchaseManager(purchaseRecords: PurchaseRecord.samples)
    }

    /// 空管理器
    static var empty: PurchaseManager {
        PurchaseManager(purchaseRecords: [])
    }
}

// MARK: - Wallet 测试数据

extension Wallet {
    /// 正常余额钱包
    static var normalBalance: Wallet {
        Wallet(balance: 1000.0)
    }
}

// MARK: - ModelContainer 测试数据

@MainActor
struct PreviewDataHelper {
    /// 创建空的测试容器
    static func createEmptyContainer() -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        // swiftlint:disable:next force_try
        let container = try! ModelContainer(
            for: Toy.self, Wallet.self, PurchaseRecord.self,
            configurations: configuration
        )

        // 只创建钱包
        let wallet = Wallet(balance: 1000.0)
        container.mainContext.insert(wallet)

        return container
    }

    /// 创建包含完整测试数据的容器
    static func createSampleContainer() -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        // swiftlint:disable:next force_try
        let container = try! ModelContainer(
            for: Toy.self, Wallet.self, PurchaseRecord.self,
            configurations: configuration
        )

        let context = container.mainContext

        // 创建钱包
        let wallet = Wallet(balance: 650.0)
        context.insert(wallet)

        // 创建玩具
        Toy.allSamples.forEach { context.insert($0) }

        // 创建购买记录
        PurchaseRecord.samples.forEach { context.insert($0) }

        // swiftlint:disable:next force_try
        try! context.save()

        return container
    }
}
#endif
