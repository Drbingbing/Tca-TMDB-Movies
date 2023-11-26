//
//  UpcomingMoviesView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import ComposableArchitecture
import TMDBLibrary
import SwiftUI

struct UpcomingMoviesView: View {
    
    var store: StoreOf<UpcomingMoviesFeature>
    
    init() {
        store = Store(initialState: UpcomingMoviesFeature.State()) { UpcomingMoviesFeature() }
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
    UpcomingMoviesView()
}
