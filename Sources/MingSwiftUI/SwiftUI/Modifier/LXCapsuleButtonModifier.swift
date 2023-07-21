//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2022/7/6.
//

import SwiftUI

public struct LXCapsuleButtonModifier: ViewModifier {
    
    /// 字體顏色
    var color: Color
    /// 字體大小
    var size: CGFloat
    /// 字體寬度
    var weight: Font.Weight
    /// 有邊框 / 填滿
    var boder: Bool
    /// 邊框寬度
    var boderWidth: CGFloat
    /// v邊距
    var vPadding: CGFloat
    /// h邊距
    var hPadding: CGFloat

    public init(color: Color,
                size: CGFloat = 9,
                weight: Font.Weight = .regular,
                boder: Bool = false,
                boderWidth: CGFloat = 1,
                vPadding: CGFloat = 3,
                hPadding: CGFloat = 5)
    {
        self.color = color
        self.size = size
        self.weight = weight
        self.boder = boder
        self.boderWidth = boderWidth
        self.vPadding = vPadding
        self.hPadding = hPadding
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(boder ? color  : .white)
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)
            .background(
                Capsule()
                    .strokeBorder(lineWidth: boderWidth) // 有邊線
                    .foregroundColor(color)
                    .opacity(boder ? 1 : 0)
            )
            .background(
                Capsule()
                    .fill(color) // // 無邊線
                    .opacity(boder ? 0 : 1)
            )
    }
}

public struct LSCapsuleButtonModifier: ViewModifier {
    
    var size: CGFloat
    var weight: Font.Weight
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var fontColor: Color

    public init(size: CGFloat = 14,
         weight: Font.Weight = .black,
         width: CGFloat = 52,
         height: CGFloat = 32,
         color: Color = .accentColor,
         fontColor: Color = .white) {
        self.size = size
        self.weight = weight
        self.width = width
        self.height = height
        self.color = color
        self.fontColor = fontColor
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(fontColor)
            .frame(width: width, height: height)
            .background(color)
            .clipShape(Capsule())
    }
}

struct LXCapsuleButtonModifierDemo: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .modifier(LXCapsuleButtonModifier(color: .accentColor, boder: true))
            Text("Hello, World!")
                .modifier(LXCapsuleButtonModifier(color: .red, boder: false))
            Text("Hello, World!")
                .modifier(LXCapsuleButtonModifier(color: .red, boder: true))
            Text("Hello, World!")
                .modifier(LXCapsuleButtonModifier(color: .green,
                                                  size: 20,
                                                  weight: .black,
                                                  boder: true,
                                                  boderWidth: 2,
                                                  vPadding: 10,
                                                  hPadding: 50))
        }
    }
}

struct LXCapsuleButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        LXCapsuleButtonModifierDemo()
    }
}
