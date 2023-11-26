//
//  HomeNavigationHeader.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI
import TMDBLibrary

struct HomeNavigationHeader: View {
    
    
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("講話大舌頭，歡迎你")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image("chrome-cast")
                    .asThumbnail()
                    .button(.scaled)
                Image("magnifying-glass")
                    .asThumbnail()
                    .button(.scaled)
            }
            
            HomeSortPagerView()
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
    HomeNavigationHeader()
        .environment(\.colorScheme, .dark)
}
