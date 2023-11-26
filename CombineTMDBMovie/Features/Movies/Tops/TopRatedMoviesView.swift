//
//  TopRatedMoviesView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct TopRatedMoviesView: View {
    
    var store: StoreOf<TopRatedMoviesFeature>
    
    init() {
        store = Store(initialState: TopRatedMoviesFeature.State()) { TopRatedMoviesFeature() }
        store.send(.viewInit)
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
                            .button(style: .scaled)
                            .onAppear {
                                store.send(.cellWillDisplay(movie))
                            }
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
    TopRatedMoviesView()
}
