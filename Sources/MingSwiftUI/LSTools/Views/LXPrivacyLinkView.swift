//
//  LXPrivacyLinkView.swift
//  eco2
//
//  Created by minghui on 2022/3/9.
//

import SwiftUI
import PureSwiftUI
import UIKit

// 使用者條款與隱私權政策連結
public struct LXPrivacyLinkItem {
    public init(textColor: Color = Color(UIColor.secondaryLabel),
                linkColor: Color = .accentColor,
                checkedColor: Color = .green,
                keyHaveRead: LocalizedStringKey = "本人已詳閱",
                keyTerms: LocalizedStringKey = "使用者條款",
                keyAnd: LocalizedStringKey = "和",
                keyPrivacy: LocalizedStringKey = "隱私權政策",
                keyAgree: LocalizedStringKey = "並同意XXX查證資料之正確性")
    {
        self.linkColor = linkColor
        self.textColor = textColor
        self.checkedColor = checkedColor
        self.keyHaveRead = keyHaveRead
        self.keyTerms = keyTerms
        self.keyAnd = keyAnd
        self.keyPrivacy = keyPrivacy
        self.keyAgree = keyAgree
    }
    
    var textColor: Color
    var linkColor: Color
    var checkedColor: Color
    var keyHaveRead: LocalizedStringKey
    var keyTerms: LocalizedStringKey
    var keyAnd: LocalizedStringKey
    var keyPrivacy: LocalizedStringKey
    var keyAgree: LocalizedStringKey
}

public struct LXPrivacyLinkView: View {
    public init(item: LXPrivacyLinkItem = .init(),
                checked: Binding<Bool>,
                termsAction: @escaping () -> Void,
                privacyAction: @escaping () -> Void)
    {
        self.item = item
        self._checked = checked
        self.termsAction = termsAction
        self.privacyAction = privacyAction
    }
    
    @Binding var checked: Bool
    var termsAction: () -> Void
    var privacyAction: () -> Void
    private var item: LXPrivacyLinkItem
    
    public var body: some View {
        VStack {
            HStack (spacing: 4) {
                Button {
                    checked.toggle()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(checked ? item.checkedColor : Color(UIColor.tertiaryLabel))
                }
                
                VStack (alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.keyHaveRead)
                            .foregroundColor(item.textColor)
                        
                        Button(action: termsAction) {
                            Text(item.keyTerms)
                                .underline()
                                .foregroundColor(item.linkColor)
                        }

                        Text(item.keyAnd)
                            .foregroundColor(item.textColor)
                        
                        Button(action: privacyAction) {
                            Text(item.keyPrivacy)
                                .underline()
                                .foregroundColor(item.linkColor)
                        }
                    }
                    
                    Text(item.keyAgree)
                        .foregroundColor(item.textColor)
                }
                .font(.footnote)
            }
        }
    }
}

struct LXPrivacyLinkView_Previews: PreviewProvider {
    static var previews: some View {
        LXPrivacyLinkView(checked: .constant(true)) {
            //
        } privacyAction: {
            //
        }

    }
}
