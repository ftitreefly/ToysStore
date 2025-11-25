//
//  MainContentView.swift
//  ToysStore
//
//  主界面视图
//

import SwiftUI
import SwiftData

struct MainContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PurchaseRecord.purchaseDate, order: .reverse) private var purchaseRecords: [PurchaseRecord]
    @Query private var toys: [Toy]
    @Query private var wallets: [Wallet]
    @State private var showingUnlockAlert = false

    private var wallet: Wallet? {
        wallets.first
    }

    private var purchaseManager: PurchaseManager {
        PurchaseManager(purchaseRecords: purchaseRecords)
    }

    private var regularToys: [Toy] {
        toys.filter { !$0.isPremium }
    }

    private var premiumToys: [Toy] {
        toys.filter { $0.isPremium }
    }

    var body: some View {
        NavigationStack {
            HSplitView {
                VStack {
                    WalletBarView(wallet: wallet)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            toySection(title: "玩具", regularToys)
                            toySection(title: "高级玩具", premiumToys)
                        }
                        .padding()
                    }
                }
                .frame(minWidth: 500)

                PurchaseListView(manager: purchaseManager)
                    .frame(minWidth: 350, maxWidth: 450)
            }
            .frame(minHeight: 500)
            .navigationTitle("玩具商店 ToysStore \(ToysStoreApp.version)")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: checkUnlockStatus) {
                        Label("检查解锁状态", systemImage: "lock.shield")
                    }
                }
            }
        }
        .alert("解锁状态", isPresented: $showingUnlockAlert) {
            Button("确定", role: .cancel) { }
        } message: {
            Text(Store.shared.storeStatusDescription())
        }
    }

    @ViewBuilder
    private func toySection(title: String, _ toys: [Toy]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                if !toys.isEmpty && toys.first!.isPremium {
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.orange)
                }
            }

            if !toys.isEmpty && toys.first!.isPremium && Store.shared.storeStatus() == .locked {
                LockedMessageView()
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 16)], spacing: 16) {
                    ForEach(toys) { toy in
                        ToyRowView(toy: toy, wallet: wallet)
                    }
                }
            }
        }
    }

    private func checkUnlockStatus() {
        showingUnlockAlert = true
    }
}

#if DEBUG
#Preview("空状态") {
    MainContentView()
        .modelContainer(PreviewDataHelper.createEmptyContainer())
}

#Preview("有数据") {
    MainContentView()
        .modelContainer(PreviewDataHelper.createSampleContainer())
}
#endif
