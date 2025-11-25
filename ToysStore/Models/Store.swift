//
//  Store.swift
//  ToysStore
//
//  Store
//

import Foundation

@MainActor
final class Store {
    static let shared = Store()

    private init() {}

    func storeStatus() -> StoreStatus {
        PremiumManager.shared.isCoreUnlocked() ? StoreStatus.unlocked : .locked
    }

    func storeStatusDescription() -> String {
        storeStatus().statusDescription
    }
}

enum StoreStatus {
    case locked
    case unlocked

    var statusDescription: String {
        switch self {
        case .locked:
            "未解锁"
        case .unlocked:
            "已解锁"
        }
    }
}
