//
//  TextFieldDelegate.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/29.
//

import SwiftUI
import SwiftUIIntrospect

extension View {
    func textFieldStatusByIntrospect(_ isBecomeFirstResponder: Binding<Bool>) -> some View {
        modifier(TextFieldStatusByIntrospectModifier(isBecomeFirstResponder: isBecomeFirstResponder))
    }
}

private final class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isBecomeFirstResponder: Binding<Bool>?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isBecomeFirstResponder?.wrappedValue = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isBecomeFirstResponder?.wrappedValue = false
    }
}

private struct TextFieldStatusByIntrospectModifier: ViewModifier {
    
    @State var delegate = TextFieldDelegate()
    @Binding var isBecomeFirstResponder: Bool
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                delegate.isBecomeFirstResponder = $isBecomeFirstResponder
            }
            .introspect(.textField, on: .iOS(.v14, .v15, .v16, .v17)) { textField in
                textField.delegate = delegate
            }
    }
}
