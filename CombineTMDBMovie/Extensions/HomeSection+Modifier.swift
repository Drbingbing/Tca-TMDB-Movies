//
//  HomeSection+Modifier.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI

private struct SectionNamableModifier: ViewModifier {
    
    var text: Text
    
    init(text: Text) {
        self.text = text
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            text
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.horizontal, 10)
                .foregroundStyle(.white)
            content
        }
        .padding(.bottom, 4)
    }
}

extension View {
    
    func asSection(_ label: Text) -> some View {
        self.modifier(SectionNamableModifier(text: label))
    }
}
