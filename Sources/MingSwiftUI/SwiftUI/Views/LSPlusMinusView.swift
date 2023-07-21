//
//  LSPlusMinusView.swift
//  eco2
//
//  Created by minghui on 2022/5/14.
//

import SwiftUI

public struct LSPlusMinusView: View {
    @Binding var value: Int
    var range: ClosedRange<Int> = 1...5

    public init(value: Binding<Int>, range: ClosedRange<Int> = 1...5) {
        self._value = value
        self.range = range
    }
    
    public var body: some View {
        HStack {
            Button {
                guard let min = range.min(), value > min else {
                    return
                }
                value -= 1
            } label: {
                Image(systemName: "minus.square.fill")
                    .font(.system(size: 22))
            }
            
            Text("\(value)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.primary)
                .opacity(0.6)
//                .fontSizeColor(size: 14, weight: .medium, color: .ecoGray500)
                .frame(minWidth: 20)
            
            Button {
                guard let max = range.max(), value < max else {
                    return
                }
                value += 1
            } label: {
                Image(systemName: "plus.square.fill")
                    .font(.system(size: 22))
            }

        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.white)
        )
    }
}

struct LSPlusMinusView_Previews: PreviewProvider {
    static var previews: some View {
        LSPlusMinusView(value: .constant(1))
            .padding()
            .background(Color.gray)
            .previewLayout(.sizeThatFits)
    }
}
