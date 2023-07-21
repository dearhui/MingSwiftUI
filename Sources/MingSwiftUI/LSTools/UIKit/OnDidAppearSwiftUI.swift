//
//  OnDidAppearSwiftUI.swift
//  eco2
//
//  Created by minghui on 2022/7/4.
//

import SwiftUI

struct ViewControllerLifecycleHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewControllerLifecycleHandler.Coordinator {
        Coordinator(onDidAppear: onDidAppear)
    }

    let onDidAppear: () -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerLifecycleHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewControllerLifecycleHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onDidAppear: (() -> Void)?

        init(onDidAppear: (() -> Void)?) {
            self.onDidAppear = onDidAppear

            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
           (onDidAppear ?? {})()
        }
    }
}

struct DidAppearModifier: ViewModifier {
    let onDidAppearCallback: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .background(ViewControllerLifecycleHandler(onDidAppear: onDidAppearCallback ?? {}))
    }
}

extension View {
    /// Use UIKit's viewDidAppear，in IOS14, subview's onAppear() is different iOS15
    /// - Parameter perform: callback
    /// - Returns: some View
    public func onDidAppear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(DidAppearModifier(onDidAppearCallback: perform))
    }
}

