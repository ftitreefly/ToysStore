//
//  ToyRowView.swift
//  ToysStore
//
//  玩具视图组件
//

import SwiftUI
import SwiftData

struct ToyRowView: View {
    let toy: Toy
    let wallet: Wallet?
    @Environment(\.modelContext) private var modelContext
    @State private var isHovered = false
    @State private var showingPurchaseAlert = false
    @State private var showingInsufficientBalanceAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(toy.emoji)
                    .font(.system(size: 40))

                VStack(alignment: .leading, spacing: 4) {
                    Text(toy.name)
                        .font(.headline)

                    if toy.isPremium {
                        Label("高级", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                }

                Spacer()
            }

            Text(toy.toyDescription)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Divider()

            HStack {
                Text(toy.price.toPriceString())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)

                Spacer()

                Button(action: purchaseToy) {
                    Label("购买", systemImage: "cart.fill")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondary.opacity(0.1))
                .shadow(color: isHovered ? Color.black.opacity(0.1) : Color.clear, radius: 4)
        )
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
        .alert("购买确认", isPresented: $showingPurchaseAlert) {
            Button("取消", role: .cancel) { }
            Button("确认购买") {
                processPurchase()
            }
        } message: {
            Text(purchaseConfirmationMessage)
        }
        .alert("余额不足", isPresented: $showingInsufficientBalanceAlert) {
            Button("确定", role: .cancel) { }
        } message: {
            Text(insufficientBalanceMessage)
        }
    }

    private func purchaseToy() {
        showingPurchaseAlert = true
    }

    private func processPurchase() {
        guard let wallet = wallet else {
            showingInsufficientBalanceAlert = true
            return
        }

        if wallet.hasEnoughBalance(for: toy.price) {
            wallet.deduct(toy.price)

            let purchaseRecord = PurchaseRecord(
                toyName: toy.name,
                toyEmoji: toy.emoji,
                price: toy.price
            )
            modelContext.insert(purchaseRecord)

            try? modelContext.save()
        } else {
            showingInsufficientBalanceAlert = true
        }
    }

    // MARK: - Computed Properties

    private var purchaseConfirmationMessage: String {
        let message = "确定要购买 \(toy.name) 吗？\n价格：\(toy.price.toPriceString())"
        return message
    }

    private var insufficientBalanceMessage: String {
        var message = "您的余额不足！\n需要：\(toy.price.toPriceString())"
        if let wallet = wallet {
            message += "\n当前余额：\(wallet.balance.toPriceString())"
        }
        return message
    }
}

#if DEBUG
#Preview("普通玩具") {
    ToyRowView(
        toy: Toy.sampleRegular[0],  // 积木
        wallet: .normalBalance
    )
    .padding()
    .frame(width: 250)
}

#Preview("高级玩具") {
    ToyRowView(
        toy: Toy.samplePremium[0],  // 智能机器人
        wallet: .normalBalance
    )
    .padding()
    .frame(width: 250)
}
#endif
