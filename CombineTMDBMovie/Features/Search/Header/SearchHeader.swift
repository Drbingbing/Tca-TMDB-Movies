//
//  SearchHeader.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import TMDBLibrary

struct SearchHeader: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("back")
                .resize(width: 32, height: 32)
            HStack {
                Image("magnifying-glass")
                    .resize(width: 16, height: 16)
                    .foregroundStyle(.sonicSilver)
                TextField("搜尋人物、節目、電影⋯⋯", text: .constant(""))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.primaryGray)
            }
        }
        .padding(.leading, 10)
        .padding(.trailing, 20)
        
    }
}

#Preview {
    SearchHeader()
        .background {
            Color.richBlack.background(.regularMaterial)
        }
        .environment(\.colorScheme, .dark)
}
