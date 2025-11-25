//
//  LockedMessageView.swift
//  ToysStore
//
//  锁定提示视图组件
//

import SwiftUI

struct LockedMessageView: View {

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)

            Text("高级玩具已锁定")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("请解锁高级功能以查看和购买高级玩具")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

#if DEBUG
#Preview {
    LockedMessageView()
    .padding()
    .frame(width: 400)
}
#endif
