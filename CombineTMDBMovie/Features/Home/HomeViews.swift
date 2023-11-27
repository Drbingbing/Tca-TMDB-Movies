//
//  HomeViews.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI
import TMDBLibrary

struct HomeViews: View {
    var body: some View {
        ZStack(alignment: .top) {
            MoviesView()
                .padding(.top, 60)
            HomeNavigationHeader()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack
                .ignoresSafeArea()
                .overlay(.regularMaterial)
        }
        
    }
}

#Preview {
    RootTabBarView()
}
