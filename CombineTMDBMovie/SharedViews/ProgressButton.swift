//
//  ProgressButton.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import TMDBLibrary

struct ProgressButton<Label: View>: View {
    var label: Label
    @Binding var value: Bool
    
    init(_ value: Binding<Bool>, label: () -> Label) {
        _value = value
        self.label = label()
    }
    
    var body: some View {
        if value {
            ProgressView().frame(width: 26, height: 26)
        } else {
            label
                .button(action: { value = true }, style: .scaled)
        }
    }
}

#Preview {
    ProgressButton(.constant(false)) {
        Image("chrome-cast")
    }
}
