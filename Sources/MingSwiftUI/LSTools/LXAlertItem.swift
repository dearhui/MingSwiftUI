//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/1/5.
//

import SwiftUI

public struct LXAlertItem: Identifiable {
    public init(title: String, message: String, cancelAction: (() -> Void)? = nil, primaryButton: Alert.Button? = nil, secondaryButton: Alert.Button? = nil) {
        self.title = title
        self.message = message
        self.cancelAction = cancelAction
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
    
    var title: String
    var message: String
    var cancelAction: (()->Void)?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
    
    public var id: String {
        return title
    }
    
    public var alert: Alert {
        if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
            return .init(title: Text(title), message: Text(message), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
        
        return .init(title: Text(title), message: Text(message), dismissButton: .default(Text("button_alert_ok", bundle: .module)))
    }
}
