//
//  PremiumToysManager.swift
//  ToysStore
//
//  高级玩具管理
//

import Foundation

@MainActor
final class PremiumManager {
    static let shared = PremiumManager()

    private init() {}

    func isCoreUnlocked() -> Bool {
        false
    }
    
    deinit {}
}
