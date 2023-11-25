//
//  Button+Extensions.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import SwiftUI

extension View {
    
    public func button<S: ButtonStyle>(_ style: S, tap: @escaping () -> Void = {}) -> some View {
        asButton(tap)
            .buttonStyle(style)
    }
    
    public func asButton(_ tap: @escaping () -> Void = {}) -> some View {
        Button(action: tap) { self }
    }
}
