//
//  PlayButton.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI
import TMDBLibrary

struct PlayButton<Background: ShapeStyle>: View {
    
    var action: () -> Void
    var background: Background
    
    init(action: @escaping () -> Void, background: Background = Color.white) {
        self.background = background
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image("play")
                .resizable()
                .frame(width: 28, height: 28)
            Text("Play")
                .font(.system(size: 16, weight: .medium))
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .foregroundStyle(.primaryGray)
        .button(.scaled, tap: action)
    }
}

#Preview {
    PlayButton {}
}
