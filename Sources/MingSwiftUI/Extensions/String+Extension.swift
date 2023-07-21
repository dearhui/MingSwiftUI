//
//  File.swift
//  
//
//  Created by minghui on 2022/7/7.
//

import Foundation

extension String {
    /// 版本比較
    /// 修正 compare 的問題，避免有 2.0 比 1.0.2 小的情況發生
    /// https://sarunw.com/posts/how-to-compare-two-app-version-strings-in-swift/
    /// 本來是可以用 compare
    /// https://stackoverflow.com/questions/27932408/compare-two-version-strings-in-swift
    public func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."

        var versionComponents = self.components(separatedBy: versionDelimiter) // <1>
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)

        let zeroDiff = versionComponents.count - otherVersionComponents.count // <2>

        if zeroDiff == 0 { // <3>
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff)) // <4>
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros) // <5>
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric) // <6>
        }
    }
    
    /// 判斷是否為支援的版本
    /// - Parameters:
    ///   - current: 現在的版本
    ///   - support: 支援的版本, 如果是空字串都會 true，如果是奇怪的字串會報錯
    /// - Returns: true : 支援, false : 不支援
    public func isVersionSupported(support: String) -> Bool {
        return !(self.versionCompare(support) == .orderedAscending)
    }
    
    public static func randomDigit(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
}

extension String {
    public var isUUID: Bool {
        let regex = try! NSRegularExpression(pattern: "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
}
