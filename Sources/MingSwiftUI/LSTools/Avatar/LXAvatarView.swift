//
//  LSAvatarView.swift
//  eco2
//
//  Created by minghui on 2021/9/22.
//

import SwiftUI
import SDWebImageSwiftUI
import PureSwiftUI

public struct LXAvatarView: View {
    var url: String?
    @Binding var image: UIImage?
    var action: (()->Void)?
    
    @State private var isPresentActionSheet = false
    @State private var isPresentPhotoPicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    public init(url: String?, image: Binding<UIImage?>, action: (()->Void)? = nil) {
        self.url = url
        self._image = image
        self.action = action
    }
    
    var imageView: some View {
        ZStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
            } else {
                EmptyView()
            }
        }
    }
    
    public var body: some View {
        Button(action: {
            isPresentActionSheet.toggle()
        }, label: {
            WebImage(url: URL(string: url ?? ""))
                .resizable()
//                .placeholder(
//                    Image(systemName: "person.circle.fill")
//                        .renderingMode(.template)
//                )
                .scaledToFill()
                .frame(width: 100, height: 100)
                .background(
                    Image(systemName: "person.circle.fill")
                        .renderingMode(.template)
                        .resizedToFill()
                        .greedyFrame()
                        .foregroundColor(.gray300)
                )
                .clipShape(Circle())
                .overlay(
                    imageView
                        .scaledToFill()
                        .clipShape(Circle())
                )
                .overlay(
                    Image("ic_camera", bundle: .module)
//                        .renderingMode(.template)
                        .resizedToFill()
                        .frame(32)
//                        .foregroundColor(.gray400)
//                        .backgroundColor(.white)
//                        .clipShape(Circle())
                    , alignment: .bottomTrailing
                )
                .actionSheet(isPresented: $isPresentActionSheet) {
                    ActionSheet(title: Text("Avatar", bundle: .module), buttons: actionButtons)
                }
                .sheet(isPresented: $isPresentPhotoPicker, content: {
                    LXImagePickerView(sourceType: sourceType) { image in
                        self.image = image
                        self.action?()
                    }
                })
        }) // button
    }
    
    var actionButtons: [ActionSheet.Button] {
        
        var buttons:[ActionSheet.Button] = []
        
        let library:ActionSheet.Button = .default(Text("Photo Library", bundle: .module)) {
            sourceType = .photoLibrary
            isPresentPhotoPicker.toggle()
        }
        buttons.append(library)
        
        let photo:ActionSheet.Button = .default(Text("Camera", bundle: .module)) {
            sourceType = .camera
            isPresentPhotoPicker.toggle()
        }
        buttons.append(photo)
        
        if image != nil {
            let del:ActionSheet.Button = .default(Text("Cancel Selection", bundle: .module)) {
                    image = nil
                }
            buttons.append(del)
        }
        
        buttons.append(.cancel(Text("Cancel", bundle: .module)))
        
        return buttons
    }
}

struct LSAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        LXAvatarView(url: "", image: .constant(nil))
    }
}
