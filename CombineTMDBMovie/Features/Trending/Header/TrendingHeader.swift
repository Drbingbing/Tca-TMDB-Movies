//
//  TrendingHeader.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import TMDBLibrary

struct TrendingHeader: View {
    @Binding var selectedSort: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("哈燒新榜")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image("chrome-cast")
                    .asThumbnail()
                    .button(style: .scaled)
                Image("magnifying-glass")
                    .asThumbnail()
                    .button(style: .scaled)
            }
            
            TrendingSortPagersView(selectedSort: $selectedSort)
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
        .background {
            Color.blackChocolate
                .overlay(.regularMaterial)
        }
    }
}

#Preview {
    TrendingView()
        .environment(\.colorScheme, .dark)
}
