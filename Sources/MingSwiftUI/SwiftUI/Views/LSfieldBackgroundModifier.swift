//
//  LSfieldBackgroundModifier.swift
//  
//
//  Created by minghui on 2022/8/4.
//

import SwiftUI

public struct LSfieldBackgroundModifier: ViewModifier {
    public var verified: Bool = true
    
    public init(verified: Bool = true) {
        self.verified = verified
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(verified ? Color.clear : Color.redWrong)
                    .background(
                        Color.grayF2
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
            )
    }
}
