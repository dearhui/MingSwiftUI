//
//  Color+System+Extension.swift
//  topchurch_ios
//
//  Created by minghui on 2023/3/31.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

public extension Color {
    
    struct UIKit {
        static let systemBackground = Color(UIColor.systemBackground)
        static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
        static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
        static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
        static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
        static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
        static let label = Color(UIColor.label)
        static let secondaryLabel = Color(UIColor.secondaryLabel)
        static let tertiaryLabel = Color(UIColor.tertiaryLabel)
        static let systemFill = Color(UIColor.systemFill)
        static let secondarySystemFill = Color(UIColor.secondarySystemFill)
        static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
        static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
        static let placeholderText = Color(UIColor.placeholderText)
        static let separator = Color(UIColor.separator)
        static let opaqueSeparator = Color(UIColor.opaqueSeparator)
        static let link = Color(UIColor.link)
        static let systemIndigo = Color(UIColor.systemIndigo)
        static let systemGray = Color(UIColor.systemGray)
        static let systemGray2 = Color(UIColor.systemGray2)
        static let systemGray3 = Color(UIColor.systemGray3)
        static let systemGray4 = Color(UIColor.systemGray4)
        static let systemGray5 = Color(UIColor.systemGray5)
        static let systemGray6 = Color(UIColor.systemGray6)
        
        static let systemRed = Color(UIColor.systemRed)
        static let systemGreen = Color(UIColor.systemGreen)
        static let systemBlue = Color(UIColor.systemBlue)
        static let systemOrange = Color(UIColor.systemOrange)
        static let systemYellow = Color(UIColor.systemYellow)
        static let systemPink = Color(UIColor.systemPink)
        static let systemPurple = Color(UIColor.systemPurple)
        static let systemTeal = Color(UIColor.systemTeal)
    }
}
#endif
