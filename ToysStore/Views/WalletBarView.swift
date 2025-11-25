//
//  WalletBarView.swift
//  ToysStore
//
//  钱包余额视图组件
//

import SwiftUI

struct WalletBarView: View {
    let wallet: Wallet?

    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Text("钱包金额：")
                Text((wallet?.balance ?? 0).toPriceString())
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }

            Spacer()

            Text(Store.shared.storeStatusDescription())
                .foregroundStyle(Store.shared.storeStatus() == .unlocked ? .green : .red)
        }
        .padding()
        .font(.title2)
        .fontWeight(.bold)
    }
}

#if DEBUG
#Preview {
    WalletBarView(wallet: .normalBalance)
}
#endif
