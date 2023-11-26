//
//  MoviesView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI

struct MoviesView: View {
    
    var body: some View {
        
        ScrollView {
            RecommendMovieView {
                PlayButton(action: {})
                AddFavoriteButton(action: {})
            }
            .onTapGesture {}
            
            UpcomingMoviesView()
                .asSection(Text("Upcoming"))
            
            NowPlayingMoviesView()
                .asSection(Text("Now playing"))
            
            TopRatedMoviesView()
                .asSection(Text("Top Rated"))
            
            Color.clear.frame(height: 20)
        }
        
    }
}

#Preview {
    RootTabBarView()
}
