//
//  ButtonStyles.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import SwiftUI

public struct ScaledButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.spring, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaledButtonStyle {
    
    public static var scaled: ScaledButtonStyle { ScaledButtonStyle() }
}
