//
//  LSQRCodeView.swift
//  eco2
//
//  Created by minghui on 2022/6/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreGraphics

public struct LSQRCodeView: View {
    
    @Binding var qrString: String
    var type: BarcodeType
    private let context = CIContext()
    
    public init(qrString: Binding<String>, type: LSQRCodeView.BarcodeType = .qrCode) {
        self._qrString = qrString
        self.type = type
    }
    
    public enum BarcodeType: String {
        case qrCode = "CIQRCodeGenerator"
        case barcode128 = "CICode128BarcodeGenerator"
        case aztecCode = "CIAztecCodeGenerator"
        case PDF417 = "CIPDF417BarcodeGenerator"
    }
    
    public var body: some View {
        GeometryReader { reader in
            Image(uiImage: generateQRCode(from: qrString, size: reader.size))
                .resizable()
                .scaledToFit()
                .frame(width: reader.size.width, height: reader.size.height)
        }
    }
    
    func generateQRCode(from string: String, size: CGSize) -> UIImage {
        
        guard let filter = CIFilter(name: type.rawValue) else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
//        filter.message = Data(string.utf8)
        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        
        guard let outputImage = filter.outputImage else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
        
        let scaleX = (size.width / outputImage.extent.size.width)
        let scaleY = (size.height / outputImage.extent.size.height)
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaledImage = outputImage.transformed(by: transform)
        
        guard let cgimg = context.createCGImage(scaledImage, from: scaledImage.extent) else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
        
        return UIImage(cgImage: cgimg)
    }
}

struct LSQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LSQRCodeView(qrString: .constant("123456789"), type: .barcode128)
                .frame(width: 200, height: 50)
            
            LSQRCodeView(qrString: .constant("123456789"), type: .qrCode)
                .frame(width: 200, height: 200)
        }
    }
}
