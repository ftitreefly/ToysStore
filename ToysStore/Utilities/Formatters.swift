//
//  Formatters.swift
//  ToysStore
//
//  统一的格式化工具
//

import Foundation

enum Formatters {
    /// 价格
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    /// 日期
    static let dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }()

    /// 格式化价格
    static func formatPrice(_ amount: Double) -> String {
        currency.string(from: NSNumber(value: amount)) ?? "¥0.00"
    }

    /// 格式化日期
    static func formatDate(_ date: Date) -> String {
        dateTime.string(from: date)
    }
}

// MARK: - Double Extension

extension Double {
    func toPriceString() -> String {
        Formatters.formatPrice(self)
    }
}
