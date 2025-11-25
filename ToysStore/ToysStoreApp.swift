//
//  ToysStoreApp.swift
//  ToysStore
//
//  应用入口文件
//

import SwiftUI
import SwiftData

@main
struct ToysStoreApp: App {
    static let version = "1.0"
    let modelContainer: ModelContainer

    init() {
        // Set app icon
        AppIconGenerator.setAppIcon(emoji: "🧸")

        do {
            modelContainer = try Self.createModelContainer()
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainContentView()
        }
        .windowStyle(.automatic)
        .modelContainer(modelContainer)
    }

    // MARK: - Private Methods

    /// Create and initialize ModelContainer
    private static func createModelContainer() throws -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Toy.self, Wallet.self, PurchaseRecord.self,
            configurations: configuration
        )

        let context = container.mainContext
        try initializeWallet(in: context)
        try initializeToys(in: context)
        try context.save()

        return container
    }

    /// Initialize wallet
    private static func initializeWallet(in context: ModelContext) throws {
        let descriptor = FetchDescriptor<Wallet>()
        let existingWallets = try context.fetch(descriptor)

        guard existingWallets.isEmpty else { return }
        context.insert(Wallet(balance: 1000.0))
    }

    /// Initialize toy data
    private static func initializeToys(in context: ModelContext) throws {
        let descriptor = FetchDescriptor<Toy>()
        let existingToys = try context.fetch(descriptor)

        guard existingToys.isEmpty else { return }

        let sampleToys = [
            // 普通玩具
            Toy(name: "积木", description: "经典彩色积木，培养创造力", price: 29.99, isPremium: false, emoji: "🧱"),
            Toy(name: "毛绒熊", description: "可爱的泰迪熊，陪伴成长", price: 49.99, isPremium: false, emoji: "🧸"),
            Toy(name: "拼图", description: "100片拼图，锻炼专注力", price: 19.99, isPremium: false, emoji: "🧩"),
            Toy(name: "彩色画笔", description: "24色水彩画笔套装", price: 39.99, isPremium: false, emoji: "🖍️"),

            // 高级玩具（需要解锁）
            Toy(name: "智能机器人", description: "AI智能机器人，对话互动", price: 299.99, isPremium: true, emoji: "🤖"),
            Toy(name: "无人机", description: "4K航拍无人机，探索天空", price: 599.99, isPremium: true, emoji: "🚁"),
            Toy(name: "VR眼镜", description: "虚拟现实体验设备", price: 399.99, isPremium: true, emoji: "🥽")
        ]

        sampleToys.forEach { context.insert($0) }
    }
}
