//
//  PurchaseRecordsListView.swift
//  ToysStore
//
//  购买记录列表视图组件
//

import SwiftUI

struct PurchaseListView: View {
    let manager: PurchaseManager

    var body: some View {
        VStack {
            HStack {
                Label("购买记录", systemImage: "list.bullet.rectangle")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()

            if manager.isEmpty {
                emptyStateView
            } else {
                recordsList
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.badge.questionmark")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("暂无购买记录")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("购买玩具后，记录会显示在这里")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var recordsList: some View {
        List {
            Section {
                ForEach(manager.groupedPurchases) { group in
                    VStack(spacing: 8) {
                        HStack {
                            Text(group.toyEmoji)
                                .font(.system(size: 24))
                            Text(group.toyName)
                                .font(.body)
                            Spacer()
                        }

                        HStack(spacing: 16) {
                            HStack {
                                Text("数量")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("×\(group.quantity)")
                                    .font(.body)
                            }

                            HStack {
                                Text("单价")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(group.unitPrice.toPriceString())
                                    .font(.body)
                            }

                            Spacer()

                            Text(group.subtotal.toPriceString())
                                .font(.headline)
                                .foregroundStyle(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            Section {
                HStack {
                    Text("总计")
                        .font(.headline)
                        .fontWeight(.bold)

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text("共 \(manager.recordCount) 件")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(manager.totalPriceString)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

#if DEBUG
#Preview("空状态") {
    PurchaseListView(manager: .empty)
}

#Preview("有数据") {
    PurchaseListView(manager: .sample)
        .frame(width: 400, height: 600)
}
#endif
