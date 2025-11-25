//
//  Wallet.swift
//  ToysStore
//
//  钱包数据模型
//

import Foundation
import SwiftData

@Model
class Wallet {
    var balance: Double

    init(balance: Double = 1000.0) {
        self.balance = balance
    }

    func hasEnoughBalance(for amount: Double) -> Bool {
        balance >= amount
    }

    func deduct(_ amount: Double) {
        balance -= amount
    }
}
