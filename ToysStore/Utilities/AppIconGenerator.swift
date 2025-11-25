//
//  AppIconGenerator.swift
//  ToysStore
//
//  Runtime Emoji app icon generator
//

import AppKit

enum AppIconGenerator {
    /// Convert Emoji to NSImage and set as app icon
    static func setAppIcon(emoji: String, title: String = "ToysStore \(ToysStoreApp.version)", size: CGFloat = 512) {
        guard let image = createEmojiImage(emoji: emoji, title: title, size: size) else { return }
        NSApplication.shared.applicationIconImage = image
    }

    /// Create NSImage from Emoji with title text
    private static func createEmojiImage(emoji: String, title: String, size: CGFloat) -> NSImage? {
        let image = NSImage(size: NSSize(width: size, height: size))

        image.lockFocus()

        // Padding for better display in system
        let padding = size * 0.1
        let contentSize = size - padding * 2

        // Draw gradient background (scaled down area)
        let rect = NSRect(x: padding, y: padding, width: contentSize, height: contentSize)
        let cornerRadius = contentSize * 0.2
        let path = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)

        // Soft gradient background color
        let gradient = NSGradient(
            starting: NSColor(calibratedRed: 0.98, green: 0.95, blue: 0.90, alpha: 1.0),
            ending: NSColor(calibratedRed: 0.95, green: 0.88, blue: 0.80, alpha: 1.0)
        )
        gradient?.draw(in: path, angle: -45)

        // Draw Emoji
        let emojiFontSize = contentSize * 0.5
        let emojiFont = NSFont.systemFont(ofSize: emojiFontSize)
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: emojiFont
        ]

        let emojiSize = emoji.size(withAttributes: emojiAttributes)
        let emojiRect = NSRect(
            x: (size - emojiSize.width) / 2,
            y: padding + contentSize * 0.32,
            width: emojiSize.width,
            height: emojiSize.height
        )
        emoji.draw(in: emojiRect, withAttributes: emojiAttributes)

        // Draw title text
        let titleFontSize = contentSize * 0.13
        let titleFont = NSFont.systemFont(ofSize: titleFontSize, weight: .semibold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: NSColor(calibratedRed: 0.35, green: 0.25, blue: 0.20, alpha: 1.0)
        ]

        let titleSize = title.size(withAttributes: titleAttributes)
        let titleRect = NSRect(
            x: (size - titleSize.width) / 2,
            y: padding + contentSize * 0.1,
            width: titleSize.width,
            height: titleSize.height
        )
        title.draw(in: titleRect, withAttributes: titleAttributes)

        image.unlockFocus()

        return image
    }
}
