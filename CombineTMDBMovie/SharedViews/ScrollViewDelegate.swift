//
//  ScrollViewDelegate.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/29.
//

import SwiftUI
import SwiftUIIntrospect

extension ScrollView {
    
    func dismissKeyboardWhenDeceratingIsBegin(_ metric: CGFloat = 20) -> some View {
        self
            .modifier(DismissKeyboardModifier(metric: metric))
    }
}

private final class DismissKeyboardScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    var metric: CGFloat = 20
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isDecelerating {
            scrollView.window?.endEditing(true)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

private struct DismissKeyboardModifier: ViewModifier {
    
    @State var store = DismissKeyboardScrollViewDelegate()
    
    var metric: CGFloat
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                store.metric = metric
            }
            .introspect(.scrollView, on: .iOS(.v14, .v15, .v16, .v17)) { scrollview in
                scrollview.delegate = store
            }
    }
}
