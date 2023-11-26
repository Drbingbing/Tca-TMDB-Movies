//
//  AddFavoriteButton.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI

struct AddFavoriteButton<Background: ShapeStyle>: View {
    
    var action: () -> Void
    var background: Background
    
    init(action: @escaping () -> Void, background: Background = Material.regularMaterial) {
        self.action = action
        self.background = background
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image("plus")
                .resizable()
                .renderingMode(.template)
                .frame(width: 28, height: 28)
            Text("Favorite")
                .font(.system(size: 16, weight: .medium))
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .background {
            Color.clear
                .background(background)
                .environment(\.colorScheme, .dark)
        }
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .foregroundStyle(.white)
        .button(action: action, style: .scaled)
    }
}

#Preview {
    AddFavoriteButton(action: {})
}
