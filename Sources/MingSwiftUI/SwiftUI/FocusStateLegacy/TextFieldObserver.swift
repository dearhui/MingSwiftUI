//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/7/25.
//

import UIKit

class TextFieldObserver: NSObject, UITextFieldDelegate {
    var onReturnTap: () -> () = {}
    var onEditingBegin: () -> () = {}
    var onEditingEnd: () -> () = {}
    weak var forwardToDelegate: UITextFieldDelegate?
    
    @available(iOS 2.0, *)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return forwardToDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        onEditingBegin()
        forwardToDelegate?.textFieldDidBeginEditing?(textField)
    }

    @available(iOS 2.0, *)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return forwardToDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldDidEndEditing(_ textField: UITextField) {
        forwardToDelegate?.textFieldDidEndEditing?(textField)
    }

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        onEditingEnd()
        forwardToDelegate?.textFieldDidEndEditing?(textField)
    }

    @available(iOS 2.0, *)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        forwardToDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    @available(iOS 13.0, *)
    func textFieldDidChangeSelection(_ textField: UITextField) {
        forwardToDelegate?.textFieldDidChangeSelection?(textField)
    }

    @available(iOS 2.0, *)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        forwardToDelegate?.textFieldShouldClear?(textField) ?? true
    }
    
    @available(iOS 2.0, *)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturnTap()
        return forwardToDelegate?.textFieldShouldReturn?(textField) ?? true
    }
}
