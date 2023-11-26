//
//  MoviesView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI

struct MoviesView: View {
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            RecommendMovieView {
                PlayButton(action: {})
                AddFavoriteButton(action: {})
            }
            .onTapGesture {}
            
            UpcomingMoviesView()
                .asSection(Text("即將上映"))
            
            NowPlayingMoviesView()
                .asSection(Text("現正熱播"))
            
            TopRatedMoviesView()
                .asSection(Text("最高評分"))
            
            Color.clear.frame(height: 20)
        }
        
    }
}

#Preview {
    RootTabBarView()
}
