//
//  NowPlayingMoviesView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct NowPlayingMoviesView: View {
    
    var store: StoreOf<NowPlayingFeature>
    
    init() {
        store = Store(initialState: NowPlayingFeature.State()) { NowPlayingFeature() }
        store.send(.onAppear)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: [GridItem(.flexible(minimum: 120, maximum: .infinity))]
            ) {
                WithViewStore(store, observe: \.movies) { viewStore in
                    ForEach(viewStore.state, id: \.movieID) { movie in
                        PreviewCardView(image: movie.posterPath)
                            .frame(width: 110)
                            .button(.scaled)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .background(.clear)
        .frame(height: 110 * 1.3)
    }
}

#Preview {
    NowPlayingMoviesView()
}
