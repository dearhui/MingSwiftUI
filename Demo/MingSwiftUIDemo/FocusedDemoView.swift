//
//  FocusedDemoView.swift
//  MingSwiftUIDemo
//
//  Created by minghui on 2023/7/25.
//

import SwiftUI
import MingSwiftUI

enum Field: Hashable, CustomStringConvertible, CaseIterable {
    var description: String {
        switch self {
        case .username:
            return "Username"
        case .password:
            return "Password"
        case .email:
            return "Email"
        }
    }
    
    case username
    case password
    case email
}

struct FocusedDemoView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
//    @FocusState private var focusedField: Field?
    @FocusStateLegacy private var focusedField: Field?
    
    @StateObject private var viewModel = FocusedDemoViewModel()

    var body: some View {
        VStack (spacing: 20) {
            TextField("Username", text: $viewModel.username) {
                focusedField = nil
            }
                .padding()
                .roundedBackgroundStyle(.field)
//                .focused($focusedField, equals: .username)
                .focusedLegacy($focusedField, equals: .username)
                .submitLabel(.next)
            
            SecureField("Password", text: $password)
                .padding()
                .roundedBackgroundStyle(.field)
//                .focused($focusedField, equals: .password)
                .focusedLegacy($focusedField, equals: .password)
            
            TextField("Email", text: $username)
                .padding()
                .roundedBackgroundStyle(.field)
//                .focused($focusedField, equals: .username)
                .focusedLegacy($focusedField, equals: .email)
            
            LeadingGridCustom(tags: Field.allCases) { item in
                Button {
                    print("\(item.description) button tapped")
                    focusedField = item
                } label: {
                    Text(item.description)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .capsuleStyle(.attention)
                }
            }
            Button {
                print("Dismiss button tapped")
                focusedField = nil
            } label: {
                Text("Dismiss")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .roundedBackgroundStyle(.button)
            }
        }
        .padding()
    }
}

struct FocusedDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FocusedDemoView()
    }
}
