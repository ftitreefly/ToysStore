# 🧸 玩具商店 (ToysStore)

一个使用 SwiftUI 构建的 macOS 玩具商店演示应用。本项目专为 **Frida 动态插桩演示** 而设计。

## ✨ 功能特点

- 🛒 浏览和购买玩具
- 💰 钱包系统与余额管理
- 🔐 高级玩具解锁机制
- 📋 购买历史记录追踪
- 🎨 现代化 SwiftUI 界面，采用 HSplitView 布局

## 🛠 技术栈

- **UI 框架**: SwiftUI
- **数据框架**: SwiftData
- **编程语言**: Swift 6+ (纯 Swift，无 Objective-C)
- **目标平台**: macOS 14.0+
- **开发环境**: Xcode 15+

## 📁 项目结构

```
ToysStore/
├── ToysStoreApp.swift          # 应用入口
├── Models/
│   ├── Toy.swift               # 玩具数据模型
│   ├── Wallet.swift            # 钱包数据模型
│   ├── Purchase.swift          # 购买记录与管理器
│   ├── Store.swift             # 商店状态管理器
│   └── PremiumManager.swift    # 高级功能解锁管理器
├── Views/
│   ├── MainContentView.swift   # 主分栏视图
│   ├── ToyRowView.swift        # 玩具卡片组件
│   ├── WalletBarView.swift     # 钱包状态栏
│   ├── PurchaseListView.swift  # 购买历史列表
│   └── LockedMessageView.swift # 锁定状态提示
└── Utilities/
    ├── Formatters.swift        # 货币与日期格式化工具
    ├── PreviewData.swift       # Preview 测试数据
    └── AppIconGenerator.swift  # 运行时应用图标生成器
```

## 🚀 快速开始

### 环境要求

- macOS 14.0 或更高版本
- Xcode 15.0 或更高版本

### 构建与运行

1. 克隆仓库
2. 使用 Xcode 打开 `ToysStore.xcodeproj`
3. 选择目标设备 (Mac)
4. 按 `Cmd + R` 构建并运行

## 🔬 架构概览

本应用专为 Frida 动态插桩演示而设计。
### 核心组件

**PremiumManager** - 核心解锁状态管理：
```swift
@MainActor
final class PremiumManager {
    static let shared = PremiumManager()
    
    func isCoreUnlocked() -> Bool {
        true  // 核心解锁逻辑
    }
}
```

**Store** - 商店状态管理，基于枚举的状态系统：
```swift
@MainActor
final class Store {
    static let shared = Store()
    
    func storeStatus() -> StoreStatus {
        PremiumManager.shared.isCoreUnlocked() ? .unlocked : .locked
    }
}

enum StoreStatus {
    case locked
    case unlocked
}
```

### 数据模型

- **Toy**: SwiftData 模型，包含名称、描述、价格、高级标志和表情符号
- **Wallet**: SwiftData 模型，管理余额并提供扣除和验证方法
- **PurchaseRecord**: SwiftData 模型，跟踪单个购买记录

## 📝 注意事项

- **纯 Swift 实现**: 完全使用 Swift 6+ 构建，无 Objective-C 依赖
- **内存存储**: 数据仅存储在内存中 (`isStoredInMemoryOnly: true`)，应用重启后数据会重置
- **初始钱包余额**: ¥1,000.00
- **高级解锁**: 高级玩具需要解锁（由 `PremiumManager.isCoreUnlocked()` 控制）
- **应用图标**: 运行时使用表情符号（🧸）动态生成

## 📸 截图

![ToysStore Icon](ToysStoreIcon.png)

## 📄 许可证

本项目仅供教育和演示目的使用。
