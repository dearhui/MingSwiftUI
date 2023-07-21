//
//  CustomProgressBar.swift
//  eco2
//
//  Created by minghui on 2023/7/12.
//

import SwiftUI

public struct CustomProgressBar: View {
    public var percentage: Double
    public var foregroundColor: Color
    public var backgroundColor: Color
    
    public init(percentage: Double, foregroundColor: Color, backgroundColor: Color) {
        self.percentage = percentage
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .cornerRadius(21)
                
                Rectangle()
                    .foregroundColor(foregroundColor)
                    .cornerRadius(21)
                    .frame(width: geometry.size.width * CGFloat(percentage))
            }
        }
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(
            percentage: 0.77,  // 這裡填入您需要的百分比
            foregroundColor: .red,
            backgroundColor: .gray
        )
        .frame(height: 6)
    }
}
