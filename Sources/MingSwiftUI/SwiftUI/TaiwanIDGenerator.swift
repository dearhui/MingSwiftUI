//
//  TaiwanIDGenerator.swift
//  eco2
//
//  Created by minghui on 2022/3/8.
//

import Foundation

public class TaiwanIDGenerator {
    
    static public let shared = TaiwanIDGenerator()
    
    let firstLetterMapping = ["A":"10","B":"11","C":"12","D":"13","E":"14","F":"15","G":"16","H":"17","I":"34","J":"18","K":"19","L":"20","M":"21","N":"22","O":"35","P":"23","Q":"24","R":"25","S":"26","T":"27","U":"28","V":"29","W":"32","X":"30","Y":"31","Z":"33"]
    
    /// 驗證格式
    /// - Parameter text: Input String text
    /// - Returns: true is taiwan id format
    public func verified(text: String) -> Bool{
        /// 過不了正則驗證就一定不是正確的身分證字號
        guard NSPredicate(format: "SELF MATCHES %@","^[A-Za-z]{1}[1-2]{1}[0-9]{8}$").evaluate(with: text) else {
            return false
        }
        
        /// 取得第一個字(英文)換得數字文字
        let n00 = firstLetterMapping["\(text.first!)".uppercased()]!
        /// 把換到的數字文字加上原本的數字文字
        let nn = n00 + text.suffix(from: text.index(after: text.startIndex))
        
        var ans = 0
        
        /// 將數字陣列每個字都轉成Int然後根據所在位置乘以該乘的數字 加進 ans
        nn.map{Int("\($0)")!}.enumerated().forEach{
            switch $0.offset{
            case 1...8 :
                ans += $0.element * (10 - $0.offset)
            default :
                ans += $0.element
            }
        }
        /// 確認 ans 除以 10 是否為0 ， 若為0 就是正確的
        return ans % 10 == 0
    }
    
    /// 隨機產生符合格式身分證字號
    /// - Returns: random generator a ID string
    public func generator() -> String {
        let first = firstLetterMapping.randomElement()!
        let gender = [1, 2].randomElement()!
        let subfix = String.randomDigit(ofLength: 7)
        
        let preId = "\(first.value)\(gender)\(subfix)"
        
        var ans = 0
        preId.map { Int("\($0)") }.enumerated().forEach {
            guard let value = $0.element else { return }
            
            switch $0.offset{
            case 1...8 :
                ans += value * (10 - $0.offset)
            default :
                ans += value
            }
        }
        
        let check = (10 - (ans % 10)) % 10 // if zero
        
        return "\(first.key)\(gender)\(subfix)\(check)"
    }
}

//extension String {
//    fileprivate static func randomDigit(ofLength length: Int) -> String {
//        guard length > 0 else { return "" }
//        let base = "0123456789"
//        var randomString = ""
//        for _ in 1...length {
//            randomString.append(base.randomElement()!)
//        }
//        return randomString
//    }
//}
