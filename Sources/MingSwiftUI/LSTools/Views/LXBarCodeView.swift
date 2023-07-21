//
//  LXBarCodeView.swift
//  
//
//  Created by minghui on 2023/2/14.
//

import SwiftUI
import RSBarcodes_Swift
import AVFoundation
import PureSwiftUI

public struct LXBarCodeView: View {
    public init(code: Binding<String>, type: Binding<AVMetadataObject.ObjectType> = .constant(.code39), isDisplayCodeText: Bool = false) {
        self._code = code
        self.isDisplayCodeText = isDisplayCodeText
        self._type = type
    }
    
    @Binding var code: String
    @Binding var type: AVMetadataObject.ObjectType
    var isDisplayCodeText: Bool
    @State private var codeImage: UIImage?
    @State private var isValid: Bool  = true
    
    public var body: some View {
        VStack (spacing: 0) {
            if let image = codeImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(sizeByType)
            }
            
            if !isValid {
                HStack {
                    Text("\(code)\n(\(type.rawValue) valid failure)")
                        .font(.headline)
                        .greedyWidth()
                }
                .frame(barcodeSize)
                .backgroundColor(Color(UIColor.systemGroupedBackground))
                .clipRoundedRectangle(7)
            }
            
            if isDisplayCodeText {
                Text(code)
                    .font(.callout)
            }
        }
        .onAppear {
            genCode()
        }
        .onChange(of: code) { newValue in
            genCode()
        }
        .onChange(of: type) { newValue in
            genCode()
        }
    }
    
    /// ‧轉碼系統：請以Code39型式轉碼。
    /// ‧條碼尺寸：為確保條碼機可順利讀取，請務必按照規範轉條碼。
    /// ‧條碼高度(上下)：1 公分；條碼寬度(左右)：5~5.5公分。
    /// ‧印製券面請務必包含：(1)19碼的Barcode英數字，(2)14碼的英數混合PIN碼
    /// https://stackoverflow.com/questions/16911880/how-to-display-distance-between-2-images-in-mm-cm
    /// 1 cm = 47 pixels and it is easy to find distance between 2 images in pixels..
    var oneCM: CGFloat = 70
    var barcodeSize: CGSize {
        return .init(oneCM * 5, oneCM)
    }
    
    var qrcodeSize: CGSize {
        return .init(oneCM * 3)
    }
    
    var sizeByType: CGSize {
        return type == .qr ?  qrcodeSize : barcodeSize
    }
    
    func genCode() {
        if type != .qr {
            isValid = RSUnifiedCodeValidator.shared.isValid(code, machineReadableCodeObjectType: type.rawValue)
            guard isValid else {
                return
            }
        }
        
        codeImage = RSUnifiedCodeGenerator.shared.generateCode(code, machineReadableCodeObjectType: type.rawValue, targetSize: sizeByType)
    }
}

struct LXBarCodeView_Previews: PreviewProvider {
    static var previews: some View {
        LXBarCodeView(code: .constant("A123456789012345678"))
    }
}
